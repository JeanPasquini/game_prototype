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

        // tela já está totalmente coberta: tira o player do state/sprite de
        // transição agora, sem esperar a tela terminar de abrir na sala nova
        obj_player.state = PlayerState.IDLE;
        obj_player.sprite_index = spr_player_idle;
        obj_player.image_index = 0;
        obj_player.image_speed = 1;
        obj_player.transition_phase = 0;
        obj_player.transition_room_started = false;

        // avanca a posicao do player no mapa da RUN antes de carregar a sala nova
        // (scr_room_init da sala nova ja le global.run_pos)
        if (destiny_slot != noone) global.run_pos = destiny_slot;
        global.run_entry_dir = entry_dir; // scr_room_init da sala nova usa p/ nascer na porta

        room_goto(destiny);
    }
}

// ==========================
// SAÍDA (abrindo tela)
// ==========================
else {

    img -= img_vel;

    if (img < 0) {

        obj_menu_boss_introduction.boss_introduction = false;
        obj_cam.zoom_target = 1;
        obj_cam.center_on_target = false; // volta ao enquadramento normal na sala nova
        scr_menu_lock_release("transition");
        instance_destroy();
    }
}

// ==========================
// TROCA DE ESTADO
// ==========================
if (next) {
    join = false;
}