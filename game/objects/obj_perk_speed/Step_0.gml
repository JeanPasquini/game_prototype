event_inherited();

var range = 30;

if (instance_exists(obj_player)) {
    var player = instance_find(obj_player, 0);
    var dist = point_distance(x, y, player.x, player.y);

    if (dist < range && keyboard_check_pressed(ord("E"))) {
        obj_player.spd += spd;
		audio_play_sound(sde_player_get_perk, 1, false);
		if (!instance_exists(obj_effect_perk)) {
		    instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_effect_perk);
		}
		layer_destroy_instances("perk");
    }
}
