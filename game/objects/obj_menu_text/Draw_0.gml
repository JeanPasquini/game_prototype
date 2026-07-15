draw_set_font(fnt_ui_menu_perk_selection_title);
draw_set_color(c_white);

//draw_text(x, y, description);

if(info_defination == "time_run") description = obj_control.time_run; 
if(info_defination == "damage_caused") description = obj_control.damage_caused; 
if(info_defination == "damage_taken") description = obj_control.damage_taken; 
if(info_defination == "perk_adquired") description = obj_control.perk_adquired; 
if(info_defination == "enemy_killed") description = obj_control.enemy_killed;

scr_draw_rich_text(
    x,
	y,
    description,
    image_xscale,
    1,
	align
);

draw_set_halign(fa_left);
