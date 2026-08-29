function scr_create_next_phase_door(){
	if (life <= 0) {
		var _next_phase_room = src_get_next_phase_room();

		// Sala terminal da RUN (demo: mini-boss sem "sends"): nao cria porta de
		// proxima fase. A UI ui_run_finish ja e mostrada pelo boss ao morrer.
		if (is_undefined(_next_phase_room) || _next_phase_room == noone) exit;

		global.rooms_map[$ global.current_phase][$ global.run_pos].connections.up = _next_phase_room;
	
		var _door_y = y;
		var _door_height = sprite_get_height(spr_door);
	
		while (!position_meeting(x, _door_y + (_door_height/2), obj_wall)){
			_door_y += 1;
		}
		
		while (position_meeting(x, _door_y, obj_wall)){
			_door_y -= 1;
		}
	
		// Fazer verificação caso já esteja enterrada
	
		var door = instance_create_layer(x, _door_y, "environment", obj_door);

		door.room_direction = RoomDirection.UP;
		door.current_room = room;
		door.current_phase = global.current_phase;
		door.is_boss_door = true;
		door.image_xscale = 1;
		door.image_yscale = 1;
	
		src_advance_to_next_phase();
	}
}