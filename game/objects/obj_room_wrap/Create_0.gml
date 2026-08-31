// Wrap de tela: quem sai por uma borda da sala reaparece na borda oposta.
// Criado por scr_room_init() quando a sala define global.room_wrap_enabled = true.
//
// Adicione/remova objetos-pai desta lista para controlar o que "envolve".
wrap_objs = [
	obj_player,
	obj_enemy_parent,
	obj_projectile_parent,
	obj_drop_coin,
	obj_drop_key,
	obj_drop_life,
];

wrap_margin = 16; // folga (px) antes de teleportar pra outra borda
