{ config, lib, pkgs, inputs, ... }:
let
  mkGenericDefault = lib.mkOverride 1100;

  ik-llama-server =
    lib.getExe' inputs.ik-llama.legacyPackages.${pkgs.system}.llamaPackagesCuda.llama-cpp "llama-server";

  llama-server =
    lib.getExe' pkgs.llama-cpp "llama-server";

  qwen36FastModel =
    pkgs.fetchurl {
      name = "Qwen3.6-35B-A3B-IQ4_XS-4.19bpw.gguf";
      url =
        "https://huggingface.co/byteshape/Qwen3.6-35B-A3B-MTP-GGUF/resolve/83dc80a65cb948b8e5a9dd9776eda7425180dacc/Qwen3.6-35B-A3B-IQ4_XS-4.19bpw.gguf?download=true";
      sha256 = "sha256-Ue3c6KDLY3RO3Gd7/18zg0+3y6uXQSSmtOQ8VGWKe0M=";
    };

  qwen36Model =
    pkgs.fetchurl {
      name = "Qwen3.6-27B-UD-Q4_K_XL.gguf";
      url =
        "https://huggingface.co/unsloth/Qwen3.6-27B-MTP-GGUF/resolve/5cb35eb3dcbf52dbce5f87dbc64df6aaffadcace/Qwen3.6-27B-UD-Q4_K_XL.gguf?download=true";
      sha256 = "sha256-QIVmXuNtgqZyojikPw5WQ/Lw458te9XTc/DvEOz1MJU=";
    };

  qwen36MmprojFile =
    pkgs.fetchurl {
      name = "mmproj-F16.gguf";
      url =
        "https://huggingface.co/unsloth/Qwen3.6-27B-MTP-GGUF/resolve/5cb35eb3dcbf52dbce5f87dbc64df6aaffadcace/mmproj-F16.gguf?download=true";
      sha256 = "sha256-6s9hDR7kvV7QGXoHd92PT8647vonAJBnx9SWy2j73kU=";
    };

  qwen35_36_ChatTemplate =
    pkgs.fetchurl {
      name = "Qwen3.5-3.6-chat_template.jinja";
      url =
        "https://huggingface.co/froggeric/Qwen-Fixed-Chat-Templates/raw/c31fd393e531dbacd92b6deb99a2037cc949f950/chat_template.jinja";
      sha256 = "sha256-Rkmz+j2z/aTVEXPtT/AXX95+zou8651ZXQTYYgIMl0Y=";
    };

# qwen3coderModel =
#   pkgs.fetchurl {
#     name = "Qwen3-Coder-Next-UD-IQ4_NL.gguf";
#     url =
#       "https://huggingface.co/unsloth/Qwen3-Coder-Next-GGUF/resolve/ce09c67b53bc8739eef83fe67b2f5d293c270632/Qwen3-Coder-Next-UD-IQ4_NL.gguf?download=true";
#     sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
#   };

  opencodeSandboxed = pkgs.stdenv.mkDerivation {
    pname = "opencode";
    version = "sandboxed";

    nativeBuildInputs = [ pkgs.makeWrapper ];

    buildCommand = ''
      mkdir -p $out/bin

      cat > $out/bin/opencode <<'EOF'
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      REAL="${pkgs.opencode}/bin/opencode"

      # ---------------------------------
      # host-side persistent roots
      # ---------------------------------

      mkdir -p "$HOME/.config/opencode"
      mkdir -p "$HOME/.local/share/opencode"
      mkdir -p "$HOME/.cache/opencode"

      mkdir -p "$HOME/.opencode-sandbox/.config"
      mkdir -p "$HOME/.opencode-sandbox/.cache"
      mkdir -p "$HOME/.opencode-sandbox/.local"

      # ---------------------------------
      # sandbox HOME (fake, on tmpfs)
      # ---------------------------------
      SANDBOX_HOME="/home/''${USER:-user}"

      # capture real home for filtering below
      REAL_HOME="$HOME"

      ALLOW=()
      ARGS=()
      INTERACTIVE=0

      # -----------------------------
      # parse args
      # -----------------------------
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --interactive)
            INTERACTIVE=1
            ;;
          --allow)
            shift
            [[ $# -gt 0 ]] || exit 1
            path="$(realpath "$1")"

            ALLOW+=("$path")
            ;;
          --)
            shift
            ARGS+=("$@")
            break
            ;;
          *)
            ARGS+=("$1")
            ;;
        esac
        shift
      done

      # default: cwd (but only if not under real home)
      if [[ ''${#ALLOW[@]} -eq 0 ]]; then
        cwd="$(realpath "$(pwd)")"
        ALLOW+=("$cwd")
      fi

      # dedupe
      if [[ ''${#ALLOW[@]} -gt 0 ]]; then
        mapfile -t ALLOW < <(printf "%s\\n" "''${ALLOW[@]}" | sort -u)
      fi

      # -----------------------------
      # PATH sanitization
      # -----------------------------
      IFS=: read -ra PATH_ARR <<< "''${PATH:-}"
      SANITIZED_PATH=()

      for p in "''${PATH_ARR[@]}"; do
        [[ -d "$p" ]] || continue

        SANITIZED_PATH+=("$p")
      done

      SANITIZED_PATH+=("/run/current-system/sw/bin")
      SANITIZED_PATH+=("/nix/store")

      PATH_JOINED=$(IFS=:; echo "''${SANITIZED_PATH[*]}")

      # -----------------------------
      # build bwrap
      # -----------------------------
      BWRAP=(
        ${pkgs.bubblewrap}/bin/bwrap

        --unshare-pid
        --unshare-uts
        --unshare-ipc
        --unshare-cgroup
        --die-with-parent
        --clearenv

        --setenv NIX_LD_LIBRARY_PATH "$NIX_LD_LIBRARY_PATH"
        --setenv NIX_PROFILES "$NIX_PROFILES"
        --setenv NIX_PATH "$NIX_PATH"
        --setenv NIX_GSETTINGS_OVERRIDES_DIR "$NIX_GSETTINGS_OVERRIDES_DIR"
        --setenv NIXPKGS_CONFIG "$NIXPKGS_CONFIG"
        --setenv NIX_USER_PROFILE_DIR "$NIX_USER_PROFILE_DIR"
        --setenv NIX_LD "$NIX_LD"
        --setenv NIX_XDG_DESKTOP_PORTAL_DIR "$NIX_XDG_DESKTOP_PORTAL_DIR"
        --setenv PATH "$PATH_JOINED"
        --setenv HOME "$SANDBOX_HOME"
        --setenv USER "''${USER:-user}"
        --setenv SHELL "''${SHELL:-/bin/bash}"

        # synthetic /home on tmpfs, no /home/luis from host
        --tmpfs /home
        --bind "$HOME/.opencode-sandbox" "$SANDBOX_HOME"
        --bind "$HOME/.opencode-sandbox/.config" "$SANDBOX_HOME/.config"
        --bind "$HOME/.opencode-sandbox/.local" "$SANDBOX_HOME/.local"
        --bind "$HOME/.opencode-sandbox/.cache" "$SANDBOX_HOME/.cache"

        # mount persistent config/data/cache into fake HOME
        --bind "$HOME/.config/opencode" "$SANDBOX_HOME/.config/opencode"
        --bind "$HOME/.local/share/opencode" "$SANDBOX_HOME/.local/share/opencode"
        --bind "$HOME/.cache/opencode" "$SANDBOX_HOME/.cache/opencode"

        # writable /tmp inside sandbox
        --tmpfs /tmp

        # system runtime
        --ro-bind /etc/resolv.conf /etc/resolv.conf
        --ro-bind /etc/ssl /etc/ssl
        --ro-bind /usr/bin /usr/bin
        --ro-bind /bin /bin
        --ro-bind /lib /lib
        --ro-bind /lib64 /lib64

        --proc /proc
        --dev /dev
      );

      # -----------------------------
      # bind-ro all sanitized PATH dirs (excluding /nix/store and /run/current-system/sw which are already ro-bound)
      # -----------------------------
      for p in "''${SANITIZED_PATH[@]}"; do
        for a in "''${ALLOW[@]:-}"; do
          if [[ "$p" == "$a"* ]]; then 
            continue 2
          fi
        done

        mkdir -p "$(dirname "$p")" || :
        BWRAP+=(--ro-bind "$p" "$p")
      done

      # -----------------------------
      # mount allowlist
      # -----------------------------
      for p in "''${ALLOW[@]:-}"; do
        mkdir -p "$(dirname "$p")" || :

        if [[ -d "$p" ]]; then
          BWRAP+=(--bind "$p" "$p")
        elif [[ -f "$p" ]]; then
          BWRAP+=(--bind "$(dirname "$p")" "$(dirname "$p")")
        fi
      done

      # chdir into first allowed path (if any)
      if [[ ''${#ALLOW[@]} -gt 0 ]]; then
        BWRAP+=(--chdir "''${ALLOW[0]}")
      fi

      echo "exec" "$REAL" "''${ARGS[@]}"

      if [[ "$INTERACTIVE" == "1" ]]; then
        exec "''${BWRAP[@]}" bash
      else 
        exec "''${BWRAP[@]}" "$REAL" "''${ARGS[@]}"
      fi
      EOF

      chmod +x $out/bin/opencode
    '';
  };
in with lib;
{
  services.llama-swap = {
    enable = true;
    port = 8888;

    settings = {
      healthCheckTimeout = 60;
      globalTTL = 180;

      models = {
        default = {
          proxy = "http://127.0.0.1:8881";
          cmd = ''
            ${ik-llama-server} \
              -m ${qwen36Model} \
              --fit \
              --fit-margin 3072 \
              --ctx-size 262144 \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --cache-type-k-draft q8_0 \
              --cache-type-v-draft q8_0 \
              --context-shift auto \
              --multi-token-prediction \
              --draft-p-min 0.75 \
              --draft-max 3 \
              --flash-attn on \
              --threads 16 \
              --reasoning-budget 32768 \
              --temp 0.6 \
              --port 8881 \
              --jinja \
              --chat-template-kwargs "{\"preserve_thinking\":true,\"enable_thinking\":true }" \
              --chat-template-file ${qwen35_36_ChatTemplate}
          '';
        };
        multimodal = {
          proxy = "http://127.0.0.1:8882";
          cmd = ''
            ${llama-server} \
              -m ${qwen36Model} \
              --fit on \
              --fit-target 2048 \
              --ctx-size 262144 -fa on -np 1 \
              --spec-type draft-mtp \
              --spec-draft-p-min 0.75 \
              --spec-draft-n-max 2 \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --cache-type-k-draft q8_0 \
              --cache-type-v-draft q8_0 \
              --flash-attn on \
              --presence-penalty 1.5 \
              --repeat-penalty 1.0 \
              --reasoning-budget 32768 \
              --temp 0.6 \
              --port 8882 \
              --jinja \
              --chat-template-kwargs "{\"preserve_thinking\":true,\"enable_thinking\":true }" \
              --chat-template-file ${qwen35_36_ChatTemplate}
              --mmproj ${qwen36MmprojFile}
          '';
        };
        flash = {
          proxy = "http://127.0.0.1:8883";
          cmd = ''
            ${ik-llama-server} \
              -m ${qwen36FastModel} \
              --fit \
              --fit-margin 2048 \
              --ctx-size 262144 \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --cache-type-k-draft q8_0 \
              --cache-type-v-draft q8_0 \
              --context-shift auto \
              --multi-token-prediction \
              --draft-p-min 0.75 \
              --draft-max 3 \
              --flash-attn on \
              --threads 16 \
              --reasoning-budget 32768 \
              --temp 0.6 \
              --port 8883 \
              --jinja \
              --chat-template-kwargs "{\"preserve_thinking\":true,\"enable_thinking\":true }" \
              --chat-template-file ${qwen35_36_ChatTemplate}
          '';
        };
        # coder = {
        #   proxy = "http://127.0.0.1:8883";
        #   cmd = ''
        #     ${llama-server} \
        #       -m ${qwen3coderModel} \
        #       -ngl 0 --ctx-size 262144 -fa on -np 1 \
        #       --cache-type-k q8_0 \
        #       --cache-type-v q8_0 \
        #       --flash-attn on \
        #       --presence-penalty 1.5 \
        #       --repeat-penalty 1.0 \
        #       --reasoning-budget 32768 \
        #       --temp 0.4 \
        #       --port 8883 \
        #       --jinja \
        #       --chat-template-kwargs "{\"preserve_thinking\":true,\"enable_thinking\":true }" \
        #       --chat-template-file ${qwen35_36_ChatTemplate}
        #       --mmproj ${qwen36MmprojFile}
        #   '';
        # };
      };
    };
  };

  environment.systemPackages = [
    opencodeSandboxed
    pkgs.llama-cpp
  ];
}
