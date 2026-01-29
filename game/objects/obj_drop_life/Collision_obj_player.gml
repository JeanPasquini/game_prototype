if (alarm[0] <= 0){
	if(other.life + life_restaured >= other.life_max)
	{
		other.life = other.life_max;
	}
	else
	{
		other.life += life_restaured;
	}
	
	//audio_play_sound(sde_player_coin_collect, 1, false);
	instance_destroy();
}