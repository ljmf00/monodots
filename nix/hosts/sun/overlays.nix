(final: prev: {
    ollama = (prev.ollama.override {
        acceleration = "cuda";
    });
})
