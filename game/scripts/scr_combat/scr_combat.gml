function scr_combat() {

    if (keyboard_check_pressed(ord("Z")) && alarm[1] <= 0 && !talking) {

        attack_face = face;
        state = PlayerState.ATTACK;
        damage = damage_base;

        sprite_index = spr_player_attacking;
        image_index = 0;
        image_speed = attack_speed;
		image_xscale = turn_target_dir;
		
		audio_play_sound(snd_attack_01, 1, false);
		
        // HITBOX
        var hitbox_x = x + (turn_target_dir * 25);
        var hitbox_y = y - 8;

        var hb = instance_create_layer(hitbox_x, hitbox_y, "instances", obj_player_hitbox);
        hb.damage = damage;
        hb.direction = attack_face;

        alarm[1] = 15 - (attack_speed * 5);
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
