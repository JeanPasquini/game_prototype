if (!instance_exists(obj_player)) exit;

var xx = obj_player.x;
var yy = obj_player.y - offset_y;

draw_sprite_ext(
    spr_ui_warning_menu,
    0,
    xx,
    yy,
    menu_scale,
    menu_scale,
    0,
    c_white,
    alpha_warning
);

draw_set_font(warning_font);
draw_set_color(c_white);
draw_set_alpha(alpha_warning);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(
    xx,
    yy,
    message_warning,
    text_scale,
    text_scale,
    0
);

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
