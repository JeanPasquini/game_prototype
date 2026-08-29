// ===== UI do aviso de ANOMALIA =====
if (!variable_global_exists("anomaly_ui_active") || !global.anomaly_ui_active) exit;

var a = global.anomaly_ui_a;
if (a <= 0) exit;

var title = global.anomaly_ui_title;
var desc  = global.anomaly_ui_desc;
var yoff  = global.anomaly_ui_yoff;

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var cy = gh * 0.30 + yoff;

var has_desc = (string_length(desc) > 0);
var max_w = clamp(gw * 0.7, 240, 1000);

var _tfont = fnt_ui_menu_perk_selection_title;
var _dfont = fnt_ui_menu_perk_description;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_font(_tfont);
var th = string_height("Ay") * 1.25;

var dh = 0;
if (has_desc) {
    draw_set_font(_dfont);
    dh = string_height_ext(desc, -1, max_w);
}

var band_h = th + (has_desc ? dh + 24 : 0) + 46;
var by1 = cy - band_h * 0.5;
var by2 = cy + band_h * 0.5;

// faixa de fundo
draw_set_alpha(a * 0.78);
draw_set_color(c_black);
draw_rectangle(0, by1, gw, by2, false);

// linhas de destaque
draw_set_alpha(a);
draw_set_color(c_white);
draw_rectangle(0, by1,     gw, by1 + 2, false);
draw_rectangle(0, by2 - 2, gw, by2,     false);

// titulo
draw_set_font(_tfont);
draw_set_color(c_white);
var ty = has_desc ? (cy - dh * 0.5 - 4) : cy;
draw_text_transformed(gw * 0.5, ty, string_upper(title), 1.25, 1.25, 0);

// descricao
if (has_desc) {
    draw_set_font(_dfont);
    draw_set_color(make_color_rgb(205, 205, 205));
    draw_text_ext(gw * 0.5, cy + th * 0.5 + 6, desc, -1, max_w);
}

// reset do estado de desenho
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
