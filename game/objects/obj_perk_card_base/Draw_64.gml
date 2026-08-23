draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);

if (spr_frame == noone) exit;

// ease igual ao menu de status do obj_player: cubic ease-out no fade,
// "back" ease (leve overshoot) no pop de escala
var spawn_fade = 1 - power(1 - spawn_anim_t, 3);

var back_c1 = 1.70158;
var back_c3 = back_c1 + 1;
var spawn_pop = 1 + back_c3 * power(spawn_anim_t - 1, 3) + back_c1 * power(spawn_anim_t - 1, 2);
var spawn_scale = lerp(0.7, 1, spawn_pop);

var despawn_fade  = despawn_anim_t;
var despawn_scale = lerp(0.7, 1, despawn_anim_t);

var anim_alpha = spawn_fade * despawn_fade;
var scale_now  = ui_scale * spawn_scale * despawn_scale;

if (anim_alpha <= 0) exit;

var border_scale = scale_now;
var border_alpha = 1;

if (selected)
{
    border_scale = scale_now + sin(select_time * 0.15) * 0.06;
    border_alpha = 0.6 + sin(select_time * 0.2) * 0.4;
}

var frame_w = sprite_get_width(spr_frame) * scale_now;
var frame_h = sprite_get_height(spr_frame) * scale_now;

var fx = x - frame_w * 0.5;
var fy = y - frame_h * 0.5;

draw_set_alpha(anim_alpha);
draw_sprite_ext(
    spr_frame,
    0,
    x,
    y,
    scale_now,
    scale_now,
    0,
    c_white,
    anim_alpha
);

if (selected && spr_ui_perk_select != noone)
{
    draw_set_alpha(border_alpha * anim_alpha);
    draw_sprite_ext(
        spr_ui_perk_select,
        0,
        x,
        y,
        border_scale,
        border_scale,
        0,
        c_white,
        border_alpha * anim_alpha
    );
    draw_set_alpha(anim_alpha);
}

var pad = 20;

var icon_x = 17 + size_frame_icon * 0.5;
var icon_y = 28 + size_frame_icon * 0.5;

var title_x = size_frame_icon * scale_now - (size_frame_icon * 0.5);
var title_y = icon_y - 6;

var desc_x = pad;
var desc_y = icon_y + size_frame_icon;

if (spr_icon != noone)
{
    draw_sprite_ext(
        spr_icon,
        0,
        fx + icon_x * scale_now,
        fy + icon_y * scale_now,
        scale_now,
        scale_now,
        0,
        c_white,
        anim_alpha
    );
}

if (font_title != noone) draw_set_font(font_title);

draw_set_alpha(anim_alpha);
draw_text(
    fx + title_x * scale_now,
    fy + title_y * scale_now,
    title_text
);

var desc_max_w = frame_w - (pad * 2 * scale_now);

if (font_desc != noone) draw_set_font(font_desc);

draw_set_alpha(anim_alpha);
draw_text_ext(
    fx + desc_x * scale_now,
    fy + desc_y * scale_now,
    desc_text,
    -1,
    desc_max_w
);

if (selected){
    draw_sprite_ext(
        spr_ui_press_e_menu,
        0,
        fx + frame_w / 2,
        fy + frame_h - (scale_now * 3),
        scale_now,
        scale_now,
        0,
        c_white,
        anim_alpha
    );

	draw_set_font(font_desc);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_set_alpha(anim_alpha);

    draw_text_transformed(
        fx + frame_w / 2,
        fy + frame_h - (scale_now * 3),
        "SELECTED",
        1,
        1,
        0
    );
}

draw_set_alpha(1);