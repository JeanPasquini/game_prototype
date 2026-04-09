function scr_combat() {

damage = damage_base;

if (keyboard_check_pressed(ord("Z")) && alarm[1] <= 0 && !talking && !is_dashing) {

	if(instance_exists(obj_perk_passive_energy_attack)) 
		obj_perk_passive_energy_attack.count_attack++;

	attack_face = face;
	state = PlayerState.ATTACK;

	attack_dir = turn_target_dir; // GUARDA A DIREÇÃO

	sprite_index = spr_player_attacking;
	image_index = 0;
	image_speed = attack_speed;
	var _scale = 1.15;
	image_xscale = attack_dir * _scale;


	alarm[1] = (60 / attack_speed);
}

if (sprite_index == spr_player_attacking) {

	if (obj_player.is_dashing){
		state = PlayerState.DASH;
		sprite_index = spr_player_dash;	
	}
    if (floor(image_index) == 1 && !attacked) {
        attacked = true;

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
    }

}
	
	if (keyboard_check_pressed(ord("X")) && !talking && energy == energy_max) {
		
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
