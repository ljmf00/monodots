(final: prev: {
    ollama = (prev.ollama.override {
        acceleration = "cuda";
    });
    openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
    };
    cudaPackages = prev.cudaPackages.overrideScope (cudaFinal: cudaPrev: {
        flags = cudaPrev.flags // {
            cmakeCudaArchitecturesString = "89";
        };
    });
    llama-cpp = (prev.llama-cpp.overrideAttrs (old: {
        cmakeFlags =
            builtins.filter
                (flag: builtins.match "-DCMAKE_CUDA_ARCHITECTURES(:STRING)?=.*" flag == null)
                (old.cmakeFlags or [])
            ++ [ "-DCMAKE_CUDA_ARCHITECTURES=89" ];
        doCheck = false;
    })).override {
        vulkanSupport = true;
        cudaSupport = true;
        blasSupport = true;
    };
})
