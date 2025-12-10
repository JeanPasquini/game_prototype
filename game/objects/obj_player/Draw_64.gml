           
var pad   = 12;
var box_w = 100;
var box_h = 110;

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var col_text   = c_white;

draw_set_color(col_text);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

var spr_w = sprite_get_width(spr_status_life);
var spr_h = sprite_get_height(spr_status_life);

var draw_x = 16;
var draw_y = 16;

for (var i = 0; i < life_max; i++)
{
	if(life > i){
		draw_sprite_ext(
        spr_status_life,
        0,
        draw_x + (i * (spr_w + 4)),
        draw_y,
        1, 1, 0, c_white, 1
    );
	}
	else{
	    draw_sprite_ext(
	        spr_status_life,
	        1,
	        draw_x + (i * (spr_w + 4)),
	        draw_y,
	        1, 1, 0, c_white, 1
	    );
	}
}

var line_h = 48;
var icon_x = draw_x;
var text_x = draw_x + 40;

// === ATTACK DAMAGE ===
draw_sprite_ext(spr_status_attack_damage, image_index,
    icon_x, draw_y + line_h * 1, 1, 1, 0, c_white, 1);

draw_text(text_x, draw_y + line_h * 1 + 16,
    string_format(damage_base, 0, 2));

// === ATTACK SPEED ===
draw_sprite_ext(spr_status_attack_speed, image_index,
    icon_x, draw_y + line_h * 2, 1, 1, 0, c_white, 1);

draw_text(text_x, draw_y + line_h * 2 + 16,
    string_format(attack_speed, 0, 2));

// === MOVE SPEED ===
draw_sprite_ext(spr_status_move_speed, image_index,
    icon_x, draw_y + line_h * 3, 1, 1, 0, c_white, 1);

draw_text(text_x, draw_y + line_h * 3 + 16,
    string_format(spd, 0, 2));
	
	// === MONEY ===
draw_sprite_ext(spr_status_money, image_index,
    icon_x, draw_y + line_h * 4, 1, 1, 0, c_white, 1);

draw_text(text_x, draw_y + line_h * 4 + 16,
    string_format(money, 0, 2));
