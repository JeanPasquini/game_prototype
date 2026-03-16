function src_jumping_chasing_movement(){

	 return function () {

        // pausa entre saltos
        if (pause_timer > 0) {
            pause_timer--;
            return;
        }

        // verifica se está no chão
        var on_ground = (y >= ystart);

        if (on_ground) {
			currentMovement = EnemyState.ONGROUND;
            y = ystart;
            vsp = 0;

            // decide movimento horizontal
            switch (jump_state) {
                case JumpState.LEFT:
                    hsp = -jump_speed;
                    if (x <= xstart - maxRandomMovement)
                        jump_state = JumpState.LEFT_MIDDLE;
                break;

                case JumpState.LEFT_MIDDLE:
                    hsp = jump_speed;
                    if (x >= xstart)
                        jump_state = JumpState.RIGHT;
                break;

                case JumpState.RIGHT:
                    hsp = jump_speed;
                    if (x >= xstart + maxRandomMovement)
                        jump_state = JumpState.RIGHT_MIDDLE;
                break;

                case JumpState.RIGHT_MIDDLE:
                    hsp = -jump_speed;

                    if (x <= xstart)
                        jump_state = JumpState.LEFT;
                break;
            }
			
            // inicia salto
            vsp = -jump_force;
        }
        else {
            // fase aérea
            vsp += grv;
			currentMovement = EnemyState.JUMPING;
        }

        // aplica movimento
        x += hsp;
        y += vsp;

        // aterrissagem
        if (y >= ystart) {
            y = ystart;
            vsp = 0;
            pause_timer = jump_pause;
        }
    }

}