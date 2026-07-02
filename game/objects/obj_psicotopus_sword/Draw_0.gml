// Inherit the parent event
event_inherited();

if (upward > 0) {
	var progress = 1 - (upward / upward_max);

	var emerge_threshold = 0.5; 

	draw_sprite(spr_psicotopus_projectile_sword_preparing, false, origin_local_x, origin_local_y);
	sprite_index = spr_psicotopus_projectile_sword;

	if (progress < emerge_threshold) {
		image_angle = 90;
	}
	else {
		var float_progress = (progress - emerge_threshold) / (1 - emerge_threshold);

		var float_wobble = sin(float_timer * 0.7) * float_amp_angle * float_progress;

		var dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);

		var angle_diff = angle_difference(dir_to_player, 90);
		var base_angle = 90 + angle_diff * float_progress;

		var spin_boost = (1 - float_progress) * 360 * float_progress;

		image_angle = base_angle + float_wobble + spin_boost;
	}
}
else {
	sprite_index = spr_psicotopus_projectile_sword;
	image_angle = direction;
}