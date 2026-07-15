if(instance_exists(obj_psicotopus)){
	if(obj_psicotopus.currentAttackState == AttackState.TRIPLE_VERTICAL || obj_psicotopus.currentAttackState == AttackState.TRIPLE_RICOCHET){
	}
	else{
		instance_destroy();	
	}
}
else{
	instance_destroy();	
}

scr_audio_emitter(x, y, emitterAudio);

if (shake_amount > 0) {
    shake_amount -= shake_decay;
    if (shake_amount < 0) shake_amount = 0;
}

x = obj_psicotopus.x;
y = obj_psicotopus.y - 5;



