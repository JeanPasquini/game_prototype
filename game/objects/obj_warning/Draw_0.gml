if (!instance_exists(obj_player)) exit;

var xx = obj_player.x;
var yy = obj_player.y - offset_y;

draw_set_font(warning_font);

// TAMANHO
var text_w = scr_rich_text_width(message_warning, text_scale);
var text_h = string_height("A") * text_scale;

// PADDING
var padding_x = 20;
var padding_y = 25;

// BOX
var box_w = text_w + padding_x;
var box_h = text_h + padding_y;

// NINE SLICE
draw_sprite_stretched(
    spr_ui_warning,
    0,
    xx - box_w * 0.5,
    yy - box_h * 0.5,
    box_w,
    box_h
);

// DRAW
draw_set_color(c_white);
draw_set_alpha(alpha_warning);

scr_draw_rich_text(
    xx - text_w * 0.5,
    yy,
    message_warning,
    text_scale,
    alpha_warning
);

// RESET
draw_set_alpha(1);