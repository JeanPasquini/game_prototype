function src_random_flying_idle_movement(){
	return function () {
	    // --- Patrulha horizontal (decide direção) ---
	    if (x >= (xstart + maxRandomMovement / 2)) {
	        direction = 180;
	    } else if (x <= (xstart - maxRandomMovement / 2)) {
	        direction = 0;
	    }

	    // --- Movimento horizontal com verificação de colisão ---
	    var _dx = lengthdir_x(movementSpeed, direction); // deslocamento pretendido neste step

	    if (scr_enemy_solid(x + _dx, y)) {
	        while (!scr_enemy_solid(x + sign(_dx), y)) {
	            x += sign(_dx);
	        }
	        direction = (direction == 0) ? 180 : 0; // bate na parede e vira pro outro lado
	        speed = 0;
	    } else {
	        speed = movementSpeed;
	    }

	    // --- Efeito de "luta contra o próprio peso" no eixo Y ---
	    var _gravity     = 0.08;
	    var _thrustForce = -1.4;
	    var _maxDrop     = 10;

	    fallSpeed += _gravity;
		
		if (maxOffsetUp == 0 &&	maxOffsetDown == 0) {
			maxOffsetUp = y - _maxDrop;
			maxOffsetDown = y + _maxDrop;
		}
		
	    if (thrustCooldown <= 0) {
	        fallSpeed = _thrustForce + random_range(-0.2, 0.2);
	        thrustCooldown = irandom_range(20, 40);
			
			if (y <= maxOffsetUp) {
				fallSpeed += .5;
			} else if (y >= maxOffsetDown) {
				fallSpeed -= .5;
			}
	    }
	    thrustCooldown--;

	    var _dy = fallSpeed;
		
	    // --- Colisão vertical com paredes/chão ---
	    if (_dy != 0) {
	        if (scr_enemy_solid(x, y + _dy)) {
	            while (!scr_enemy_solid(x, y + sign(_dy))) {
	                y += sign(_dy);
	            }
	            fallSpeed = 0;
	        } else {
	            y += _dy;
	        }
	    }
	}
}