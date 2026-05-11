if(object_exists(obj_bridge)){
	obj_bridge.recoil = true;
}

var wall_block = instance_create_layer(576, 64, "Instances", obj_wall)
wall_block.image_yscale = 9;

var wall_block2 = instance_create_layer(1152, 64, "Instances", obj_wall)
wall_block2.image_yscale = 9;

instance_destroy();