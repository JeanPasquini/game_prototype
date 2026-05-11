if(object_exists(obj_octopus)){
	instance_create_layer(960, 320, "enemy", obj_psicotopus);	
}

obj_environment_gate.actived = true;
obj_environment_gate.image_speed = 1;

instance_destroy();