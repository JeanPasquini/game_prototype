function scr_earthquake(_force, _time){
	obj_effect_earthquake_dirt.active = true;
	obj_effect_earthquake_stone.active = true;
	scr_camera_shake(_force, _time);
	
	obj_earthquake.sde_earthquake(false, false, _time * 100);
	
	// agenda o reset pra depois que o terremoto atual acabar
	call_later(_time, time_source_units_seconds, function(){
		obj_earthquake.sde_earthquake(true); // reset
	});
}