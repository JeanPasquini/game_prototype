if(instance_exists(obj_environment_torch)){
	var torch_effect = instance_create_layer(x, y, "environment", obj_environment_torch_effect);
	torch_effect.obj_followed = id;
}