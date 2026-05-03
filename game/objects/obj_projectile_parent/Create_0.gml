enum CurrentState {
	RISING,
	FALLING
}

state = CurrentState.RISING;
xStart = x;
yStart = y;
xEnd = obj_player.x;
yEnd = obj_player.y;

// Defines direction of movement
dir = sign(xEnd - xStart); // +1 right, -1 left

velocity = 1;

projectil_hit_effect = function()
	{obj_effect_unicle.scr_fx_projectil_hitting(
		x,
		y,
		undefined, //sprite
		undefined, undefined, undefined, //color
		undefined, //force
		undefined, undefined, undefined //alpha
	)};
	
emitterAudio = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance)
audio_emitter_falloff(emitterAudio, 150, obj_cam.width_, 1);