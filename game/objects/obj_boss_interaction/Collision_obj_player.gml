if (obj_player.state == PlayerState.RUN) {
	obj_player.hsp = 0;
	obj_player.state = PlayerState.IDLE;
	obj_player.sprite_index = spr_player_idle;
	obj_player.image_index = 0;
	obj_player.image_speed = 1;
}

if(object_exists(obj_octopus)){
	instance_create_layer(800, 480, "enemy", obj_psicotopus);
}

obj_environment_gate.actived = true;
obj_environment_gate.image_speed = 1;

instance_destroy();