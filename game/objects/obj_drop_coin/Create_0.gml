event_inherited();

on_collect = function(_player) {
	_player.money++;
	audio_play_sound(sde_player_coin_collect, 1, false);
};
