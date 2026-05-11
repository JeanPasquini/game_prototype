if (!instance_exists(obj_player)) exit;

var xx = obj_player.x;
var yy = obj_player.y - offset_y;

draw_set_font(warning_font);

var text_w = scr_rich_text_width(message_warning, text_scale);

var line_count = 1;

for (var i = 1; i < string_length(message_warning); i++)
{
    if (string_char_at(message_warning, i) == "\\" &&
        string_char_at(message_warning, i + 1) == "n")
    {
        line_count++;
    }
}

var line_h = string_height("A") * text_scale * 1.5;

var text_h = line_h * line_count;

var padding_x = 20;
var padding_y = 25;

var box_w = text_w + padding_x;
var box_h = text_h + padding_y;

draw_sprite_stretched(
    spr_ui_warning,
    0,
    xx - box_w * 0.5,
    yy - box_h * 0.5,
    box_w,
    box_h
);

draw_set_color(c_white);
draw_set_alpha(alpha_warning);

scr_draw_rich_text(
    xx - text_w * 0.5,
    yy - text_h * 0.5 + line_h * 0.5,
    message_warning,
    text_scale,
    alpha_warning
);

draw_set_alpha(1);