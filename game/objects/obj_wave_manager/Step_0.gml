// recalcula o total de hordas todo frame: o manager é criado pelo primeiro
// obj_spawn_enemy da sala e pode não "enxergar" os demais no momento do Create.
if (state != WaveState.COMPLETE) {
    with (obj_spawn_enemy) {
        if (wave_number > other.total_waves) other.total_waves = wave_number;
    }
}

// sala de anomalia: segura TUDO enquanto o aviso de anomalia estiver na tela.
// so quando o aviso some as hordas comecam (com o intro_delay normal depois).
if (variable_global_exists("anomaly_block_waves") && global.anomaly_block_waves) {
    if (state == WaveState.INTRO) timer = intro_delay;
    exit;
}

switch (state) {
    case WaveState.INTRO:
        timer--;
        if (timer <= 0) start_next_wave();
        break;

    case WaveState.WARNING:
        // espera todos os spawners da horda atual terminarem o aviso e gerarem o inimigo
        var pending = 0;
        with (obj_spawn_enemy) {
            if (wave_number == other.current_wave && !has_spawned) pending++;
        }
        if (pending == 0) state = WaveState.FIGHTING;
        break;

    case WaveState.FIGHTING:
        // horda só termina quando todos os inimigos foram eliminados
        if (instance_number(obj_enemy_parent) == 0) {
            if (current_wave >= total_waves) {
                state = WaveState.COMPLETE;
                // persistencia da run: slot concluido nao recria hordas ao revisitar
                if (variable_global_exists("run_pos")) run_state_mark_cleared(global.run_pos);
            } else {
                state = WaveState.BETWEEN;
                timer = between_delay;
            }
        }
        break;

    case WaveState.BETWEEN:
        timer--;
        if (timer <= 0) start_next_wave();
        break;

    case WaveState.COMPLETE:
        // fim: obj_perk detecta esse estado e libera os cards de perk
        break;
}
