if(image_index == 0 && image_speed > 0){
	state = TrapSpikeState.NOT_DAMAGE;
	image_speed = 0;
	alarm[0] = 60
}

if(image_index == 4 && image_speed > 0){
	state = TrapSpikeState.DAMAGE;
	image_speed = 0;
	alarm[1] = 60
}

if(state == TrapSpikeState.DAMAGE){
	scr_damage_with_knockback();	
}