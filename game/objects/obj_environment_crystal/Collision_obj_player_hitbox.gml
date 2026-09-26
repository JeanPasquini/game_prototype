event_inherited();

// o efeito sai girado junto com o cristal (ex.: pendurado no teto = pra baixo)
obj_effect_unicle.scr_fx_crystal_hit(x, y, env_up_dir());
var sfx = [
	attack_crystal_1,
	attack_crystal_2,
];					
scr_audio_play(sfx);