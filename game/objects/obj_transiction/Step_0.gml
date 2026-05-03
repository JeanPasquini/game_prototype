// ==========================
// ENTRADA (fechando tela)
// ==========================
if (join) {

    img += img_vel;

    if (img - img_num > cols + 1 && !next) {

        next = true;

        // 🔥 lógica especial (boss door)
        if (is_boss_door) {
            var _sends = src_get_room_sends_data(current_phase, current_room);
            var _next_phase = src_get_next_phase(current_phase);
            var _next_phase_room = _sends[$ _next_phase];
            src_replace_next_phase_room(current_phase, current_room, _next_phase, _next_phase_room);
        }

        obj_player.x = px;
        obj_player.y = py;

        room_goto(destiny);
    }
}

// ==========================
// SAÍDA (abrindo tela)
// ==========================
else {

    img -= img_vel;

    if (img < 0) {

        obj_player.state = PlayerState.IDLE;
        instance_destroy();
    }
}

// ==========================
// TROCA DE ESTADO
// ==========================
if (next) {
    join = false;
}