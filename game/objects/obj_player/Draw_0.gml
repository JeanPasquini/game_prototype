
draw_self();

function get_state_name(state_val) {
    switch (state_val) {
        case PlayerState.IDLE:         return "IDLE";
        case PlayerState.WALK:         return "WALK";
        case PlayerState.RUN:          return "RUN";
        case PlayerState.JUMP:         return "JUMP";
        case PlayerState.RUN_JUMP:	   return "RUN_JUMP";
        case PlayerState.FALL:         return "FALL";
        case PlayerState.RUN_FALL:     return "RUN_FALL";
        default:                       return "UNKNOWN";
    }
}

var texto = get_state_name(state);
var texto_x = obj_player.x;
var texto_y = obj_player.y-30;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

draw_text(texto_x, texto_y, texto);
