// Coordena as hordas de uma sala. É criado automaticamente pelo primeiro
// obj_spawn_enemy da sala; não precisa ser colocado manualmente.

enum WaveState {
    INTRO,      // espera inicial ao entrar na sala
    WARNING,    // spawners da horda atual estão avisando / gerando inimigos
    FIGHTING,   // inimigos da horda estão vivos
    BETWEEN,    // espera curta entre uma horda e a próxima
    COMPLETE    // todas as hordas terminadas
}

// intro_delay / between_delay vêm das Variable Definitions (frames)
state        = WaveState.INTRO;
timer        = intro_delay;
current_wave = 0;
total_waves  = 0;

// descobre quantas hordas existem a partir dos spawners presentes na sala
with (obj_spawn_enemy) {
    if (wave_number > other.total_waves) other.total_waves = wave_number;
}

function start_next_wave() {
    current_wave++;
    state = WaveState.WARNING;

    var _started = 0;
    with (obj_spawn_enemy) {
        if (wave_number == other.current_wave) { begin_warning(); _started++; }
    }

    // um único aviso sonoro por horda
    if (_started > 0) audio_play_sound(sde_perk_spawn_1, 5, false);
}
