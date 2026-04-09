if(life <= 0){
	for (var i = 0; i < 16; i++) {
	    var w = instance_create_layer(x, y - 5, "Instances", obj_parent_enviroment_wreckage);
	    w.sprite_index = spr_environment_box_wreckage;
	    w.image_index = i mod sprite_get_number(spr_environment_box_wreckage);
	}
}

event_inherited();

