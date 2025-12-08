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
