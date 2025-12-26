for (var i = 0; i < 8; i++) {
    var w = instance_create_layer(x, y, "Instances", obj_parent_enviroment_wreckage);
    w.sprite_index = spr_environment_vase_wreckage;
    w.image_index = i mod sprite_get_number(spr_environment_vase_wreckage);
}

instance_destroy();