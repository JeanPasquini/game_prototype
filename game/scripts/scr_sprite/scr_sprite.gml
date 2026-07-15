function scr_set_sprite_once(_spr, _flag) {
    if (!variable_instance_get(id, _flag)) {
        sprite_index = _spr;
        image_index = 0;
        image_speed = 1;
        variable_instance_set(id, _flag, true);
    }
}

function scr_get_last_sprite(id){
	id.image_index = sprite_get_number(sprite_index) - 1;
	return 
}

function scr_is_last_sprite(){
	if(image_index = sprite_get_number(sprite_index) - 1){
		return true;
	}
	else{
		return false;	
	}
}