if(obj_psicotopus.currentAttackState == AttackState.FLOOD){
	state = waterState.ATTACK;	
}
else{
	state = waterState.NORMAL;		
}

if (state == waterState.NORMAL) {
    image_yscale = lerp(image_yscale, -4, 0.05);
}
else if (state == waterState.ATTACK) {
    image_yscale = lerp(image_yscale, -5.2, 0.05);
}
