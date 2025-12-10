if(image_index == 0 && image_speed > 0){
	state = TrapSpearState.NOT_DAMAGE;
	image_speed = 0;
	alarm[0] = 60
}

if(image_index == 6 && image_speed > 0){
	state = TrapSpearState.DAMAGE;
	image_speed = 0;
	alarm[1] = 60
}

if(state == TrapSpearState.DAMAGE){
	scr_damage_with_knockback();	
}