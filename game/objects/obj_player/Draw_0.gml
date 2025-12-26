if (invencible) {
    if ((irandom_range(0,10)) < 6) {
        draw_self();
    }
} else {
    draw_self();
}


function get_state_name(state_val) {
    switch (state_val) {
        case PlayerState.IDLE:         return "IDLE";
        case PlayerState.WALK:         return "WALK";
        case PlayerState.WALK_TURN:    return "WALK_TURN";
        case PlayerState.RUN:          return "RUN";
        case PlayerState.RUN_TURN:     return "RUN_TURN";
        case PlayerState.JUMP:         return "JUMP";
        case PlayerState.RUN_JUMP:	   return "RUN_JUMP";
        case PlayerState.FALL:         return "FALL";
        case PlayerState.RUN_FALL:     return "RUN_FALL";
        case PlayerState.ATTACK:	   return "ATTACK";
        case PlayerState.TALKING:      return "TALKING";
        case PlayerState.WAIT_ATTACK:  return "WAIT_ATTACK";
        case PlayerState.DYING:        return "DYING";
        default:                       return "UNKNOWN";
    }
}

var texto = get_state_name(state);
var texto_x = obj_player.x;
var texto_y = obj_player.y-50;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

draw_text(texto_x, texto_y, texto);
