{ config, lib, pkgs, inputs, ... }:
let
  mkGenericDefault = lib.mkOverride 1100;
  ik-llama-server =
    lib.getExe' inputs.ik-llama.legacyPackages.${pkgs.system}.llamaPackagesCuda.llama-cpp "llama-server";
  llama-server =
    lib.getExe' pkgs.llama-cpp "llama-server";

  qwen36FastModel =
    pkgs.fetchurl {
      url =
        "https://huggingface.co/byteshape/Qwen3.6-35B-A3B-MTP-GGUF/resolve/83dc80a65cb948b8e5a9dd9776eda7425180dacc/Qwen3.6-35B-A3B-IQ4_XS-4.19bpw.gguf?download=true";
      sha256 = "sha256-Ue3c6KDLY3RO3Gd7/18zg0+3y6uXQSSmtOQ8VGWKe0M=";
    };

  qwen36Model =
    pkgs.fetchurl {
      url =
        "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-MTP-GGUF/resolve/b8efbbece76dc9103a6a45b7ed95b26c3932fc5f/Qwen3.6-35B-A3B-UD-Q4_K_M.gguf?download=true";
      sha256 = "sha256-CyFSXpcmcO1Z4YEuFwsnwmNVOB8GVuzE4lYX7OfaxYs=";
    };

  qwen36MmprojFile =
    pkgs.fetchurl {
      url =
        "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-MTP-GGUF/resolve/b8efbbece76dc9103a6a45b7ed95b26c3932fc5f/mmproj-F16.gguf?download=true";
      sha256 = "sha256-cfPLwffMDzDQnUHPqSTABggn68M78VrOfoZmHoVvAWA=";
    };

  qwen36ChatTemplate =
    pkgs.fetchurl {
      url =
        "https://huggingface.co/froggeric/Qwen-Fixed-Chat-Templates/raw/c31fd393e531dbacd92b6deb99a2037cc949f950/chat_template.jinja";
      sha256 = "sha256-Rkmz+j2z/aTVEXPtT/AXX95+zou8651ZXQTYYgIMl0Y=";
    };
in with lib;
{
  services.llama-swap = {
    enable = true;
    port = 8888;

    settings = {
      healthCheckTimeout = 60;
      globalTTL = 60;

      models = {
        qwen36-fast = {
          proxy = "http://127.0.0.1:8881";
          cmd = ''
            ${ik-llama-server} \
              -m ${qwen36FastModel} \
              --fit \
              --fit-margin 1664 \
              --ctx-size 131072 \
              --cache-type-k q8_0 \
              --cache-type-v q8_0 \
              --cache-type-k-draft q8_0 \
              --cache-type-v-draft q8_0 \
              --multi-token-prediction \
              --draft-p-min 0.75 \
              --draft-max 3 \
              --threads 8 \
              --temp 0.0 \
              --port 8881 \
              --jinja \
              --chat-template-kwargs "{\"preserve_thinking\":true,\"enable_thinking\":true }" \
              --chat-template-file ${qwen36ChatTemplate}
          '';

          aliases = [ "default" "fast" ];
        };
        qwen36 = {
          proxy = "http://127.0.0.1:8882";
          cmd = ''
            ${llama-server} \
              -m ${qwen36Model} \
              -ngl 15 --ctx-size 131072 -fa on -np 1 \
              --spec-type draft-mtp --spec-draft-n-max 2 \
              --port 8882 \
              --jinja \
              --chat-template-kwargs "{\"preserve_thinking\":true,\"enable_thinking\":true }" \
              --chat-template-file ${qwen36ChatTemplate} \
              --mmproj ${qwen36MmprojFile}
          '';

          aliases = [ "visual" ];
        };
      };
    };
  };
}
