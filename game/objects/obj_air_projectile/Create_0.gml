// Inherit the parent event
event_inherited();

damage = 1;

dir = point_direction(xStart, yStart, xEnd, yEnd);

projectil_hit_effect = function()
	{obj_effect_unicle.scr_fx_projectil_hitting(
		x,
		y,
		undefined, //sprite
		undefined, undefined, undefined, //color
		1, //force
		undefined, undefined, undefined //alpha
	)
	scr_audio_play([sde_enemy_cururu_hit_attack], emitterAudio);};

speed = 4;
direction = dir;
