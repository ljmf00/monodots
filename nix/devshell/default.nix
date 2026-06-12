{ pkgs, inputs }:

let
  fhsEnv = pkgs.callPackage ./fhs-env.nix { };
  bwrapFn = pkgs.callPackage ./bwrap-builder.nix { };
  sandboxFn = pkgs.callPackage ./sandbox-exec-builder.nix { };
in
pkgs.stdenv.mkDerivation {
  pname = "monodots-dev";
  version = "0.1.0";

  nativeBuildInputs = with pkgs; [ makeWrapper ];

  buildCommand = ''
    mkdir -p $out/bin

    cat > $out/bin/monodots-dev <<'MAIN_EOF'
    #!${pkgs.bash}/bin/bash
    set -euo pipefail

    ${bwrapFn}
    ${sandboxFn}

    FHS_ENV="${fhsEnv}/bin/monodots-dev-fhs"

    ALLOW=()
    ALLOW_RO=()
    DENY=()
    NETWORK=0
    NOSANDBOX=0
    DRYRUN=0
    SUBCMD=""
    SESSION_NAME=""

    usage() {
      cat <<USAGE
    Usage: monodots-dev [--network] [--no-network] [--no-sandbox] [--dry-run] \\
                        [--allow <path>] [--allow-ro <path>] [--deny <path>]
      monodots-dev create <name> [flags...]
      monodots-dev attach <name> [flags...]
      monodots-dev modify <name> [flags...]

    Commands:
      (no command)  Start a temporary sandboxed session
      create <name> Create a persistent session
      attach <name> Re-enter an existing persistent session
      modify <name> Modify a persistent session's sandbox config

    Flags:
      --allow <path>     Allow writable access to a path
      --allow-ro <path>  Allow read-only access to a path
      --deny <path>      Explicitly deny a path
      --network          Enable network access (default: off)
      --no-network       Disable network access
      --no-sandbox       Skip bwrap/sandbox-exec, raw FHS env only
      --dry-run          Print what would be done without doing it
    USAGE
    }

    parse_subcommand() {
      local args=("$@")
      SUBCMD=""
      SESSION_NAME=""
      local i=0
      for ((i=0; i<''${#args[@]}; i++)); do
        case "''${args[$i]}" in
          create|attach|modify)
            SUBCMD="''${args[$i]}"
            SESSION_NAME="''${args[$((i+1))]:-}"
            if [[ -z "$SESSION_NAME" ]]; then
              echo "error: ''${SUBCMD} requires a session name" >&2
              exit 1
            fi
            return 0
            ;;
          -h|--help)
            usage
            exit 0
            ;;
          --)
            break
            ;;
        esac
      done
    }

    parse_subcommand "$@"

    REMAINING_ARGS=()
    skip_next=0
    for arg in "$@"; do
      if [[ "$skip_next" -eq 1 ]]; then
        skip_next=0
        continue
      fi
      if [[ "$arg" == "create" || "$arg" == "attach" || "$arg" == "modify" ]]; then
        skip_next=1
        continue
      fi
      REMAINING_ARGS+=("$arg")
    done

    parse_flags() {
      ALLOW=()
      ALLOW_RO=()
      DENY=()
      NETWORK=0
      NOSANDBOX=0
      DRYRUN=0

      while [[ $# -gt 0 ]]; do
        case "$1" in
          --allow)
            shift; [[ $# -gt 0 ]] || { echo "error: --allow needs a path" >&2; exit 1; }
            ALLOW+=("$(realpath "$1")")
            ;;
          --allow-ro)
            shift; [[ $# -gt 0 ]] || { echo "error: --allow-ro needs a path" >&2; exit 1; }
            ALLOW_RO+=("$(realpath "$1")")
            ;;
          --deny)
            shift; [[ $# -gt 0 ]] || { echo "error: --deny needs a path" >&2; exit 1; }
            DENY+=("$(realpath "$1")")
            ;;
          --network)   NETWORK=1 ;;
          --no-network) NETWORK=0 ;;
          --no-sandbox) NOSANDBOX=1 ;;
          --dry-run)   DRYRUN=1 ;;
          -h|--help)   usage; exit 0 ;;
          --)          shift; break ;;
          *)
            echo "error: unknown flag $1" >&2
            usage
            exit 1
            ;;
        esac
        shift
      done
    }

    if [[ "''${#REMAINING_ARGS[@]}" -gt 0 ]]; then
      parse_flags "''${REMAINING_ARGS[@]}"
    fi

    filter_denied() {
      local -n _src=$1
      local -n _dst=$2
      local _result=()
      local p d
      for p in "''${_src[@]:-}"; do
        [[ -n "$p" ]] || continue
        local denied=0
        if [[ "''${#DENY[@]}" -gt 0 ]]; then
          for d in "''${DENY[@]}"; do
            if [[ "$p" == "$d"* ]]; then
              denied=1
              break
            fi
          done
        fi
        if [[ "$denied" -eq 0 ]]; then
          _result+=("$p")
        fi
      done
      if [[ "''${#_result[@]}" -gt 0 ]]; then
        _dst=("''${_result[@]}")
      else
        _dst=()
      fi
    }

    resolve_overrides() {
      local filtered_allow=()
      local p ro
      for p in "''${ALLOW[@]:-}"; do
        [[ -n "$p" ]] || continue
        local overridden=0
        if [[ "''${#ALLOW_RO[@]}" -gt 0 ]]; then
          for ro in "''${ALLOW_RO[@]}"; do
            if [[ "$ro" == "$p"* ]] || [[ "$p" == "$ro"* ]]; then
              overridden=1
              break
            fi
          done
        fi
        if [[ "$overridden" -eq 0 ]]; then
          filtered_allow+=("$p")
        fi
      done
      if [[ "''${#filtered_allow[@]}" -gt 0 ]]; then
        ALLOW=("''${filtered_allow[@]}")
      else
        ALLOW=()
      fi
    }

    setup_default_allow() {
      if [[ "''${#ALLOW[@]}" -eq 0 && "''${#ALLOW_RO[@]}" -eq 0 ]]; then
        local cwd
        cwd="$(realpath "$(pwd)")"
        local denied=0
        if [[ "''${#DENY[@]}" -gt 0 ]]; then
          local d
          for d in "''${DENY[@]}"; do
            if [[ "$cwd" == "$d"* ]]; then
              denied=1
              break
            fi
          done
        fi
        if [[ "$denied" -eq 0 ]]; then
          ALLOW=("$cwd")
        fi
      fi
    }

    SESSION_DIR=""

    setup_temp_session() {
      SESSION_DIR="$(mktemp -d "$HOME/.monodots-dev-tmp-XXXXXX")"
      mkdir -p "$SESSION_DIR/home" "$SESSION_DIR/root"
      trap "rm -rf '$SESSION_DIR'" EXIT
      echo "temporary session: $SESSION_DIR"
    }

    setup_persistent_session() {
      local name="$1"
      SESSION_DIR="$HOME/.monodots-dev-$name"
      if [[ ! -d "$SESSION_DIR" ]]; then
        mkdir -p "$SESSION_DIR/home" "$SESSION_DIR/root"
        write_session_config
      fi
    }

    SESSION_CONFIG_FILE=""

    write_session_config() {
      SESSION_CONFIG_FILE="$SESSION_DIR/config"
      {
        echo "ALLOW=(''${ALLOW[@]-})"
        echo "ALLOW_RO=(''${ALLOW_RO[@]-})"
        echo "DENY=(''${DENY[@]-})"
        echo "NETWORK=$NETWORK"
        echo "NOSANDBOX=$NOSANDBOX"
      } > "$SESSION_CONFIG_FILE"
    }

    read_session_config() {
      SESSION_CONFIG_FILE="$SESSION_DIR/config"
      if [[ -f "$SESSION_CONFIG_FILE" ]]; then
        source "$SESSION_CONFIG_FILE"
      fi
    }

    case "$SUBCMD" in
      create)
        setup_persistent_session "$SESSION_NAME"
        ;;
      attach)
        SESSION_DIR="$HOME/.monodots-dev-$SESSION_NAME"
        if [[ ! -d "$SESSION_DIR" ]]; then
          echo "error: session '$SESSION_NAME' not found" >&2
          exit 1
        fi
        read_session_config
        if [[ "''${#REMAINING_ARGS[@]}" -gt 0 ]]; then
          parse_flags "''${REMAINING_ARGS[@]}"
        fi
        ;;
      modify)
        SESSION_DIR="$HOME/.monodots-dev-$SESSION_NAME"
        if [[ ! -d "$SESSION_DIR" ]]; then
          echo "error: session '$SESSION_NAME' not found" >&2
          exit 1
        fi
        read_session_config
        if [[ "''${#REMAINING_ARGS[@]}" -gt 0 ]]; then
          parse_flags "''${REMAINING_ARGS[@]}"
        fi
        write_session_config
        echo "session '$SESSION_NAME' config updated"
        exit 0
        ;;
      "")
        setup_temp_session
        ;;
    esac

    SESSION_HOME="$SESSION_DIR/home"

    resolve_overrides
    setup_default_allow
    filter_denied ALLOW ALLOW
    filter_denied ALLOW_RO ALLOW_RO
    resolve_overrides

    DEFAULT_CWD="$SESSION_HOME"
    if [[ "''${#ALLOW[@]}" -gt 0 ]]; then
      DEFAULT_CWD="''${ALLOW[0]}"
    elif [[ "''${#ALLOW_RO[@]}" -gt 0 ]]; then
      DEFAULT_CWD="''${ALLOW_RO[0]}"
    fi

    if [[ "$DRYRUN" -eq 1 ]]; then
      echo "=== monodots-dev dry-run ==="
      echo "Session dir: $SESSION_DIR"
      echo "Session home: $SESSION_HOME"
      echo "Allow: ''${ALLOW[@]:-}"
      echo "Allow-RO: ''${ALLOW_RO[@]:-}"
      echo "Deny: ''${DENY[@]:-}"
      echo "Network: $NETWORK"
      echo "Nosandbox: $NOSANDBOX"
      echo "CWD: $DEFAULT_CWD"
      echo "============================"
      exit 0
    fi

    OS="$(uname -s)"

    if [[ "$OS" == "Linux" ]]; then
      if [[ "$NOSANDBOX" -eq 1 ]]; then
        exec "$FHS_ENV"
      else
        build_bwrap_args ALLOW ALLOW_RO DENY "$NETWORK" "$SESSION_HOME" "$DEFAULT_CWD" "$NOSANDBOX"
        exec "''${BWRAP_ARGS[@]}" "$FHS_ENV"
      fi
    elif [[ "$OS" == "Darwin" ]]; then
      if [[ "$NOSANDBOX" -eq 1 ]]; then
        exec "$FHS_ENV"
      else
        sb_file=$(build_sandbox_exec_profile ALLOW ALLOW_RO DENY "$NETWORK" "$SESSION_HOME" "$DEFAULT_CWD" "$NOSANDBOX")
        trap "rm -f '$sb_file'" EXIT
        exec sandbox-exec -f "$sb_file" "$FHS_ENV"
      fi
    else
      echo "error: unsupported platform: $OS" >&2
      exit 1
    fi
    MAIN_EOF

    chmod +x $out/bin/monodots-dev
    wrapProgram $out/bin/monodots-dev \
      --prefix PATH : ${pkgs.lib.makeBinPath (with pkgs; [ bash coreutils gnused gnugrep findutils ])}
  '';

  meta = with pkgs.lib; {
    description = "Sandboxed FHS development environment CLI";
    platforms = platforms.linux ++ platforms.darwin;
  };
}
