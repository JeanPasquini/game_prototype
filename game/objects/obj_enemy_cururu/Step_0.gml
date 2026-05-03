// Inherit the parent event
event_inherited();
scr_audio_emitter(x, y, emitterAudio);

image_xscale = face;

if(currentState == EnemyState.IDLE || currentState == EnemyState.CHASING){
	if(currentMovement == EnemyState.JUMPING && sprite_index != spr_enemy_cururu_falling){
		sprite_index = spr_enemy_cururu_jumping;
        image_speed = 1;
	}
	else if(currentMovement = EnemyState.ONGROUND){
		sprite_index = spr_enemy_cururu_idle;
        image_speed = 1;
	}
}
else if (currentState == EnemyState.CHARGING_ATTACK) {

}

