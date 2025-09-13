function combat() {
    // light attack (Z)
    if (keyboard_check_pressed(ord("Z"))) {
        if (state != PlayerState.LIGHT_ATTACK && state != PlayerState.HEAVY_ATTACK) {
			state = PlayerState.LIGHT_ATTACK;
			attack_timer = 10;

			damage = damage_base;

			var hitbox_x = x + (face * 25); 
			var hitbox_y = y - 8;
			var hb = instance_create_layer(hitbox_x, hitbox_y, "instances", obj_player_hitbox_1);

			hb.damage = damage;
			hb.direction = face;
        }
    }

    // heavy attack (X)
    if (keyboard_check_pressed(ord("X"))) {
        if (state != PlayerState.LIGHT_ATTACK && state != PlayerState.HEAVY_ATTACK) {
            state = PlayerState.HEAVY_ATTACK;
			attack_timer = 25;

			damage = damage_base * 2;

			var hitbox_x = x + (face * 25);
			var hitbox_y = y - 8;
			var hb = instance_create_layer(hitbox_x, hitbox_y, "instances", obj_player_hitbox_2);

			hb.damage = damage;
			hb.direction = face;
        }
    }
}
