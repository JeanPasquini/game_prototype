if (alarm[0] <= 0){
	other.money++;
	audio_play_sound(sde_player_coin_collect, 1, false);
	instance_destroy();
}