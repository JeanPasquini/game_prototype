for (var i = 0; i < ds_list_size(tentacles); i++) {
    var tentacle = tentacles[| i];
    
    if (instance_exists(tentacle)) {
        instance_destroy(tentacle);
    }
}

ds_list_clear(tentacles);
ds_list_destroy(tentacles);