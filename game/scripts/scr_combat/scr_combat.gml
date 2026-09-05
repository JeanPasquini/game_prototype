function scr_combat() {

damage = damage_base;

if (input_attack_pressed() && alarm[1] <= 0 && !talking && !global.world_was_blocked && !is_dashing) {

	if(instance_exists(obj_perk_passive_energy_attack)) 
		obj_perk_passive_energy_attack.count_attack++;

	attack_face = face;
	state = PlayerState.ATTACK;

	attack_dir = turn_target_dir; // GUARDA A DIREÇÃO

	sprite_index = spr_player_attacking;
	image_index = 0;
	image_speed = attack_speed;
	// (o lado do golpe é 100% visual no draw_sprite_ext via "face"; a máscara é fixa)

	// antecipação: comprime um pouco antes do golpe sair
	player_add_squash(-0.16, 0.12);
	attacked = false;
	attack_lunged = false;
	attack_lunge_timer = 0;
	attack_is_air = !ong;
	attack_hitbox_spawned = false; // libera 1 hitbox pra ESTE golpe

	alarm[1] = (60 / attack_speed);
}

if (state == PlayerState.ATTACK) {

	if (obj_player.is_dashing){
		state = PlayerState.DASH;
		sprite_index = spr_player_dash;
	}

	if (attack_hitbox_spawned) {
		if (attack_is_air) {
			// AR: assim que a animação completa, encerra o golpe e volta pra queda.
			// Restaura o sprite explicitamente (não deixa preso no de ataque).
			if (image_index >= image_number - 1) {
				if (vsp < 0) { state = PlayerState.JUMP; sprite_index = spr_player_jumping; }
				else         { state = PlayerState.FALL; sprite_index = spr_player_falling; }
				image_index = 0;
				image_speed = 1;
				alarm[1]    = -1;
			}
		}
		else {
			// CHÃO: segura no último frame até o alarme (peso / commitment)
			image_index = image_number - 1;
			image_speed = 0;
		}
	}

    if (floor(image_index) >= 1 && !attack_hitbox_spawned) {
        attacked = true;
        attack_hitbox_spawned = true;

        var hitbox_x = x + (attack_dir * 25);
        var hitbox_y = y - 8;

		var sfx = [
			sde_player_attack
		];
		scr_audio_play(sfx);
        hb = instance_create_layer(hitbox_x, hitbox_y, "Instances", obj_player_hitbox);
        hb.damage = damage;
        hb.direction = attack_dir;
		hb.frametime = (2 * 20) / image_speed;

		// follow-through: estica pra frente
		player_add_squash(0.36, -0.24);

		if (!attack_lunged) {
			if (attack_is_air) {
				// golpe aéreo: mantém controle no ar + leve empurrão
				hsp += attack_dir * (attack_lunge * 0.6);
				vsp = min(vsp, 1.5);   // "segura" a queda no instante do impacto
			}
			else {
				// golpe no chão: passo pra frente com deslize
				hsp = attack_dir * attack_lunge;
				attack_lunge_timer = 7;
			}
			attack_lunged = true;
		}
    }

}
	
	if (input_special_pressed() && !talking && !global.world_was_blocked && energy == energy_max) {
		
		if(instance_exists(obj_perk_active_temporal_jump)) obj_perk_active_temporal_jump.active_perk();
		if(instance_exists(obj_perk_active_space_break)) obj_perk_active_space_break.active_perk();
		if(instance_exists(obj_perk_active_black_hole)) obj_perk_active_black_hole.active_perk();

		obj_player.energy = 0;

		with(obj_hud_player_energy){
			if(!playing_energy_used){
				sprite_index = spr_ui_player_energy_used;
				image_index = 0;
				image_speed = 1;
				playing_energy_used = true;
			}
		}
	}
}

function scr_damage_with_knockback(){
var enemies = [obj_player];

if(obj_player.invencible == false){
	for (var i = 0; i < array_length(enemies); i++) {
	    with (enemies[i]) {
	        if (place_meeting(x, y, other)) { 
				
	            var dir_x = x - other.x;
	            var dir_y = y - other.y;
	            var length = sqrt(sqr(dir_x) + sqr(dir_y));
	            if (length != 0) {
	                dir_x /= length;
	                dir_y /= length;
	            }

				knockback_x = dir_x * knockback_strength;

				if (other.knockback_strength > knockback_strength) {
					knockback_x = dir_x * other.knockback_strength;
				}

	            if (abs(knockback_x) > 0.1) {
	                if (place_meeting(x + knockback_x, y, obj_wall) || place_meeting(x + knockback_x, y, obj_player)) {
	                    while (!place_meeting(x + sign(knockback_x), y, obj_wall) 
	                        && !place_meeting(x + sign(knockback_x), y, obj_player)) {
	                        x += sign(knockback_x);
	                    }
	                    knockback_x = 0;
	                } else {
	                    x += knockback_x;
	                }
	                knockback_x *= 0.95; 
	            }

	            src_show_player_damage_received(other.damage);
				
	            stagger = 100;
	            invencible = true;
	            obj_player.alarm[0] = obj_player.invencible_time;
	        }
	    }
	}
}	
}
