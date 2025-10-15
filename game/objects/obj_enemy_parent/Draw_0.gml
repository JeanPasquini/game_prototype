
function get_state_name(state_val) {
    switch (state_val) {
        case EnemyState.IDLE:         return "IDLE";
        case EnemyState.CHASING:         return "CHASING";
        case EnemyState.STAGGER:          return "STAGGER";
        case EnemyState.DOWNED:         return "DOWNED";
        default:                       return "UNKNOWN";
    }
}

draw_self();
var texto = life;
var texto_state = get_state_name(currentState);
var texto_x = other.x;
var texto_y = other.y-30;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

draw_text(texto_x, texto_y, texto);
draw_text(texto_x, texto_y-10, texto_state);