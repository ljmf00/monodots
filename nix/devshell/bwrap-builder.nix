{ pkgs }:

let
  bubblewrap = "${pkgs.bubblewrap}/bin/bwrap";
in
# Exports a bash function definition embedded into the wrapper script at build
# time.  Constructs bwrap arguments dynamically from session config at runtime.
''
# ---------------------------------
# Build bwrap arguments from config
# ---------------------------------
build_bwrap_args() {
  local -n _allow=$1
  local -n _allow_ro=$2
  local -n _deny=$3
  local network=$4
  local session_home=$5
  local default_cwd=$6
  local no_sandbox=$7
  local passwd_file=$8
  local group_file=$9
  local shadow_file=${10}

  if [[ "$no_sandbox" == "1" ]]; then
    echo "NO_SANDBOX"
    return
  fi

  local args=(
    ${bubblewrap}
    --unshare-pid
    --unshare-uts
    --unshare-ipc
    --unshare-cgroup
    --die-with-parent
    --clearenv
  )

  if [[ "$network" != "1" ]]; then
    args+=(--unshare-net)
  fi

  args+=(--setenv PATH "/usr/bin:/bin:/usr/local/bin")
  args+=(--setenv HOME "$session_home")
  args+=(--setenv USER "''${USER:-user}")
  args+=(--setenv SHELL "''${SHELL:-/bin/bash}")
  args+=(--setenv TERM "''${TERM:-xterm-256color}")

  args+=(--tmpfs /home)
  args+=(--bind "$session_home" "$session_home")
  args+=(--tmpfs /tmp)

  args+=(--ro-bind /nix/store /nix/store)
  args+=(--ro-bind /etc/resolv.conf /etc/resolv.conf)
  args+=(--ro-bind "$passwd_file" /etc/passwd)
  args+=(--ro-bind "$group_file" /etc/group)
  args+=(--ro-bind "$shadow_file" /etc/shadow)
  args+=(--proc /proc)
  args+=(--dev /dev)

  local p
  for p in "''${_allow[@]:-}"; do
    mkdir -p "$(dirname "$p")" 2>/dev/null || :
    if [[ -d "$p" ]]; then
      args+=(--bind "$p" "$p")
    elif [[ -f "$p" ]]; then
      args+=(--bind "$(dirname "$p")" "$(dirname "$p")")
    fi
  done

  for p in "''${_allow_ro[@]:-}"; do
    mkdir -p "$(dirname "$p")" 2>/dev/null || :
    if [[ -d "$p" ]]; then
      args+=(--ro-bind "$p" "$p")
    elif [[ -f "$p" ]]; then
      args+=(--ro-bind "$(dirname "$p")" "$(dirname "$p")")
    fi
  done

  local chdir_target="$default_cwd"
  if [[ -n "''${_allow[0]:-}" ]]; then
    chdir_target="''${_allow[0]}"
  fi
  args+=(--chdir "$chdir_target")

  BWRAP_ARGS=("''${args[@]}")
}
''
