// Libera o sistema de partículas e o emissor de áudio (fim natural OU saída da sala).
if (part_type_exists(spawn_pt))     part_type_destroy(spawn_pt);
if (part_system_exists(spawn_ps))   part_system_destroy(spawn_ps);
if (audio_emitter_exists(emitterAudio)) audio_emitter_free(emitterAudio);
