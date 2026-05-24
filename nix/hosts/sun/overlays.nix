(final: prev: {
    ollama = (prev.ollama.override {
        acceleration = "cuda";
    });
    openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
    };
    llama-cpp = (prev.llama-cpp.overrideAttrs (old: {
        version = "9297";

        src = prev.fetchFromGitHub {
            owner = "ggml-org";
            repo = "llama.cpp";
            rev = "a49747633055f2bea6c70e45baa19913750ea0bc";
            hash = "sha256-KwoG3uJ7aBMFVevHYBGBpY/WPUqSaEshBeAqhSdmMck=";
            leaveDotGit = true;
            postFetch = ''
                git -C "$out" rev-parse --short HEAD > $out/COMMIT
                find "$out" -name .git -print0 | xargs -0 rm -rf
            '';
        };

        npmRoot = "tools/ui";
        npmDepsHash = "sha256-Iyg8FpcTKf2UYHuK7mA3cTAqVaLcQPcS0YCa5Qf01Gc=";
    })).override { 
        vulkanSupport = true;
        cudaSupport = true;
    };
})

