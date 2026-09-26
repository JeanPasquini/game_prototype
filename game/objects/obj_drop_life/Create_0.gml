event_inherited();

life_restaured = 2;

on_collect = function(_player) {
	_player.life = min(_player.life + life_restaured, _player.life_max);
	//audio_play_sound(sde_player_coin_collect, 1, false);
};
