function scr_set_sprite_once(_spr, _flag) {
    if (!variable_instance_get(id, _flag)) {
        sprite_index = _spr;
        image_index = 0;
        image_speed = 1;
        variable_instance_set(id, _flag, true);
    }
}