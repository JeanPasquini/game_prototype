// Fim do ataque: retoma o estado/sprite de acordo com o movimento atual,
// evitando o "trava e volta pro IDLE" seco e garantindo que o sprite de
// ataque não fique preso (principalmente quando o golpe termina no ar).
image_speed = 1;
image_index = 0;

if (!ong) {
    if (vsp < 0) { state = PlayerState.JUMP; sprite_index = spr_player_jumping; }
    else         { state = PlayerState.FALL; sprite_index = spr_player_falling; }
}
else if (move_input != 0 || abs(hsp) > 1.2) {
    state = run ? PlayerState.RUN : PlayerState.WALK;
    sprite_index = run ? spr_player_running : spr_player_walking;
}
else {
    state = PlayerState.IDLE;
    sprite_index = spr_player_idle;
}
