event_inherited();

var range = 20;

if (instance_exists(obj_player)) {
    var player = instance_find(obj_player, 0);
    var dist = point_distance(x, y, player.x, player.y);

    if (dist < range && keyboard_check_pressed(ord("E"))) {
		if(array_length(obj_player.perks_obtained_run) < obj_player.perks_limit_run){
			if(obj_player.attack_speed + attack_speed >= 2.5){
				obj_player.attack_speed = 2.5;
			}
			else{
				obj_player.attack_speed += attack_speed;
			}
			audio_play_sound(sde_player_get_perk, 1, false);
			if (!instance_exists(obj_effect_perk)) {
			    instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_effect_perk);
			}
		
			array_push(obj_player.perks_obtained_run, name);
		}
		else{
			var _warning = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_warning);	
			_warning.alarm[0] = 200;
			_warning.message_warning = "Perks reached limit!"
		}
		
		layer_destroy_instances("perk");
    }
}
