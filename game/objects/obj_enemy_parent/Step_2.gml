if (is_destroyed && image_index >= (image_number - 1)) {
	global.force_music = noone;
	obj_control.enemy_killed ++;
    scr_drop_roll(drops, x, y, "drop");
    instance_destroy();
}