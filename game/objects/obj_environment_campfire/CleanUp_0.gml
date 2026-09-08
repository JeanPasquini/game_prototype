// Roda ao destruir a instancia E ao trocar de room.
// Garante que o loop do som do campfire pare e o emitter seja liberado.
audio_campfire(false, true);

if (audio_emitter_exists(emitterAudio)) {
    audio_emitter_free(emitterAudio);
}
