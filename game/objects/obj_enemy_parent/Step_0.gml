if (global.hitstop > 0) {
	speed = 0;
    exit;
}

scr_audio_emitter(x, y, emitterAudio);

// Rede de seguranca: se terminou dentro de uma parede, e expelido pro espaco livre.
// Bosses ficam de fora: a cutscene deles move x/y na mao e o unstick teleportava.
if (!is_boss) scr_enemy_unstick();

alpha = lerp(alpha, 0, 0.1);

if(freeze){
	shake_x = random_range(-0.3, 0.3);
	shake_y = random_range(-0.3, 0.3);
}
else{
	shake_x = 0;
	shake_y = 0;
}
	
knockbackSmoothing();

// GOLPE FATAL: sem animacao de morte. O inimigo estilhaca em detritos de pixel
// (obj_pixel_debris) a partir do frame de sprite atual, e e destruido no mesmo
// passo. Drops / contagem / musica migraram pra ca (antes ficavam no End Step,
// disparados no ultimo frame da animacao de morte).
if (life <= 0 && !is_destroyed) {
	is_destroyed  = true;
	currentState  = EnemyState.DYING;

	var _from_x = instance_exists(obj_player) ? obj_player.x : undefined;
	scr_enemy_shatter(id, _from_x);

	if (variable_instance_exists(id, "audio_dying")) audio_dying();

	global.force_music = noone;
	obj_control.enemy_killed++;
	scr_drop_roll(drops, x, y, "drop");

	instance_destroy();
	exit;
}

// Salvaguarda: se por algum motivo continuar vivo em DYING, nao roda a IA.
if (currentState == EnemyState.DYING) {
	exit;
}

// Idle State
if (currentState == EnemyState.IDLE) {
	idle_movement_script();
	if (distance_to_object(obj_player) < detectionRadius) {
		if (hasToCharge) currentState = EnemyState.CHARGING_ATTACK; else currentState = EnemyState.CHASING;
	} else if (detectionRadius < maxDetectionRadius && alarm[4] <= 0) {
		alarm[4] = 60;
	}
} 
// Attacking State
else if (
	currentState == EnemyState.CHASING || 
	currentState == EnemyState.CHARGING_ATTACK || 
	currentState == EnemyState.RETREAT
) {
	chasing_movement_script();
	chasing_attack_script();
}

// Ajusta o movimento pra nao atravessar solidos (parede + portao/porta fechados).
// Inimigo NAO colide com obj_player. Pode causar efeito colateral no movimento.
// Inimigos que resolvem a propria colisao (ex.: cururu) pulam esse bloco.
if (is_boss) {
	// Comportamento ORIGINAL do boss: nao atravessa parede nem player.
	if (place_meeting(x + hsp, y, obj_wall) || place_meeting(x + hsp, y, obj_player)) {
		while (!place_meeting(x + sign(hsp), y, obj_wall)
		    && !place_meeting(x + sign(hsp), y, obj_player)) {
		    x += sign(hsp);
		}
		hsp = 0;
	}
	if (place_meeting(x, y + vsp, obj_wall) || place_meeting(x, y + vsp, obj_player)) {
		while (!place_meeting(x, y + sign(vsp), obj_wall)
		    && !place_meeting(x, y + sign(vsp), obj_player)) {
		    y += sign(vsp);
		}
		vsp = 0;
	}
} else if (!handles_own_collision) {
	if (scr_enemy_solid(x + hsp, y)) {
		while (!scr_enemy_solid(x + sign(hsp), y)) {
		    x += sign(hsp);
		}
		hsp = 0;
	}

	if (scr_enemy_solid(x, y + vsp)) {
		while (!scr_enemy_solid(x, y + sign(vsp))) {
		    y += sign(vsp);
		}
		vsp = 0;
	}
}

function knockbackSmoothing(){
	if (abs(knockback_x) > 0.1 || abs(knockback_y) > 0.1) {
	    var nx = x + knockback_x * 0.5;
		var ny = y + knockback_y * 0.5;

	    var _kb_blocked = is_boss
	        ? (place_meeting(nx, ny, obj_wall) || place_meeting(nx, ny, obj_player))
	        : scr_enemy_solid(nx, ny);

	    if (!_kb_blocked) {
		    x = nx;
		    y = ny;
		}

	    knockback_x *= 0.95;
	    knockback_y *= 0.95;
	} else {
	    knockback_x = 0;
	    knockback_y = 0;
	}
}

function state_stagger() {
    hsp = 0;
    speed = 0;
    if (stagger <= 0) {
        currentState = EnemyState.IDLE;
    }
}

scr_damage_with_knockback();

if (is_boss) {
    // Comportamento ORIGINAL do boss: flip pelo image_xscale (Draw acompanha via face_scale).
    if (direction == 180) image_xscale = 1; else image_xscale = -1;
    face_scale = image_xscale;
} else {
    // Demais inimigos: flip APENAS visual, a mascara de colisao nunca espelha.
    if (direction == 180) face_scale = 1; else if (direction == 0) face_scale = -1;
    image_xscale = 1;
}