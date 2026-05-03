draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);

// =================================================
// SEGURANÇA
// =================================================
if (spr_frame == noone) exit;

// =================================================
// ANIMAÇÃO DA BORDA
// =================================================
var border_scale = ui_scale;
var border_alpha = 1;

if (selected)
{
    border_scale = ui_scale + sin(select_time * 0.15) * 0.06;
    border_alpha = 0.6 + sin(select_time * 0.2) * 0.4;
}

// =================================================
// MEDIDAS
// =================================================
var frame_w = sprite_get_width(spr_frame) * ui_scale;
var frame_h = sprite_get_height(spr_frame) * ui_scale;

var fx = x - frame_w * 0.5;
var fy = y - frame_h * 0.5;

// =================================================
// FRAME BASE (ESTÁTICO)
// =================================================
draw_set_alpha(1);
draw_sprite_ext(
    spr_frame,
    0,
    x,
    y,
    ui_scale,
    ui_scale,
    0,
    c_white,
    1
);

// =================================================
// BORDA DE SELEÇÃO (ÚNICO ELEMENTO ANIMADO)
// =================================================
if (selected && spr_ui_perk_select != noone)
{
    draw_set_alpha(border_alpha);
    draw_sprite_ext(
        spr_ui_perk_select,
        0,
        x,
        y,
        border_scale,
        border_scale,
        0,
        c_white,
        1
    );
    draw_set_alpha(1);
}

// =================================================
// LAYOUT INTERNO (ESTÁTICO)
// =================================================
var pad = 20;

var icon_x = 17 + size_frame_icon * 0.5;
var icon_y = 28 + size_frame_icon * 0.5;

var title_x = size_frame_icon * ui_scale - (size_frame_icon * 0.5);
var title_y = icon_y - 6;

var desc_x = pad;
var desc_y = icon_y + size_frame_icon;

// =================================================
// ÍCONE
// =================================================
if (spr_icon != noone)
{
    draw_sprite_ext(
        spr_icon,
        0,
        fx + icon_x * ui_scale,
        fy + icon_y * ui_scale,
        ui_scale,
        ui_scale,
        0,
        c_white,
        1
    );
}

// =================================================
// TEXTO — TÍTULO
// =================================================
if (font_title != noone) draw_set_font(font_title);

draw_text(
    fx + title_x * ui_scale,
    fy + title_y * ui_scale,
    title_text
);

// =================================================
// TEXTO — DESCRIÇÃO
// =================================================
var desc_max_w = frame_w - (pad * 2 * ui_scale);

if (font_desc != noone) draw_set_font(font_desc);

draw_text_ext(
    fx + desc_x * ui_scale,
    fy + desc_y * ui_scale,
    desc_text,
    -1,
    desc_max_w
);

if (selected){
    draw_sprite_ext(
        spr_ui_press_e_menu,
        0,
        fx + frame_w / 2,
        fy + frame_h - (ui_scale * 3),
        ui_scale,
        ui_scale,
        0,
        c_white,
        1
    );

    // Texto
	draw_set_font(font_desc);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);

    draw_text_transformed(
        fx + frame_w / 2,
        fy + frame_h - (ui_scale * 3),
        "SELECTED",
        1,
        1,
        0
    );
}