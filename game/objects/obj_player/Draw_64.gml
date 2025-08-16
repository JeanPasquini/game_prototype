
var life_atual    = clamp(life, 0, life_max); 
var damage_atual  = max(0, damage_base);      
var vel_atual     = max(0, spd);              

// --- layout ---
var pad   = 12;
var box_w = 100;
var box_h = 100;

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var x1 = gui_w - box_w - 16; 
var y1 = gui_h - box_h - 16; 
var x2 = x1 + box_w;
var y2 = y1 + box_h;

var col_bg     = make_colour_rgb(20, 22, 28);
var col_border = make_colour_rgb(80, 90, 110);
var col_text   = c_white;

draw_set_alpha(0.6); 
draw_set_color(col_bg);
draw_roundrect(x1, y1, x2, y2, false);
draw_set_alpha(1); 


draw_set_color(col_border);
draw_roundrect(x1, y1, x2, y2, true);

draw_set_color(col_text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var tx = x1 + pad;
var ty = y1 + pad;

draw_text(tx, ty,       "LFE: "       + string_format(life_atual, 0, 2));
draw_text(tx, ty + 20,  "DMG: "  + string_format(damage_atual, 0, 2));
draw_text(tx, ty + 40,  "SPD: " + string_format(vel_atual, 0, 2));
