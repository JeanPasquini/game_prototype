
var _tent = instance_create_layer(x, y + 10, "Instances", obj_psicotopus_tentacles)


ds_list_add(tentacles, _tent);

if ds_list_size(tentacles) < max_tentacles alarm[0] = spawn_tentacles_timer;
