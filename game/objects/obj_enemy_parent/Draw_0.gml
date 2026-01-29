
function get_state_name(state_val) {
    switch (state_val) {
        case EnemyState.IDLE:         return "IDLE";
        case EnemyState.CHASING:         return "CHASING";
        default:                       return "UNKNOWN";
    }
}

draw_self();
var texto = life;
var texto_state = get_state_name(currentState);
var texto_x = other.x;
var texto_y = other.y-30;

draw_set_font(fnt_enemy_states);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

draw_text_transformed(texto_x, texto_y, texto, 0.5, 0.5, 1);
draw_text_transformed(texto_x, texto_y-10, texto_state, 0.5, 0.5, 1);

if (freeze_alpha > 0) {
    gpu_set_blendmode(bm_add);
    draw_set_alpha(freeze_alpha);
    draw_set_color(c_aqua);
    draw_self();

    draw_set_color(c_white);
    draw_set_alpha(1);
    gpu_set_blendmode(bm_normal);
}

