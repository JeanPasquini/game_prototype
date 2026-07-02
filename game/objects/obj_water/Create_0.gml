enum waterState {	
	ATTACK,
	NORMAL
}

state = waterState.NORMAL;

wat_width  = sprite_get_width(sprite_index);
wat_height = sprite_get_height(sprite_index);

wat_surface = -1;

wat_shader = shWave;
wat_uTime  = shader_get_uniform(shWave, "u_time");
wat_uSpr   = shader_get_uniform(shWave, "u_springs");
wat_uCount = shader_get_uniform(shWave, "u_springCount");

wat_springCount = 48;
wat_springs     = array_create(wat_springCount * 2, 0); // [pos, vel]
wat_tension = 0.025;
wat_damping = 0.82;
wat_spread  = 0.28;