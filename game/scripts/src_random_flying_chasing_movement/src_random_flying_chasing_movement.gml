function src_random_flying_chasing_movement(){
	return function () {
	    // --- Patrulha horizontal (decide direção) ---
	    if (x >= (xstart + maxRandomMovement / 2)) {
	        direction = 180;
	    } else if (x <= (xstart - maxRandomMovement / 2)) {
	        direction = 0;
	    }

	    // --- Movimento horizontal com verificação de colisão ---
	    var _dx = lengthdir_x(movementSpeed, direction); // deslocamento pretendido neste step

	    if (place_meeting(x + _dx, y, obj_wall)) {
	        while (!place_meeting(x + sign(_dx), y, obj_wall)) {
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

	    if (yOffset >= _maxDrop || thrustCooldown <= 0) {
	        fallSpeed = _thrustForce + random_range(-0.3, 0.3);
	        thrustCooldown = irandom_range(20, 40);
	    }
	    thrustCooldown--;

	    var _dy = fallSpeed + (random(1) - 0.5) * 0.4;

	    // --- Limite de altura (idle) em relação a ystart ---
	    if (yOffset + _dy > maxOffsetDown) {
	        _dy = maxOffsetDown - yOffset;
	        fallSpeed = 0;
	    } else if (yOffset + _dy < -maxOffsetUp) {
	        _dy = -maxOffsetUp - yOffset;
	        fallSpeed = 0;
	    }

	    // --- Colisão vertical com paredes/chão ---
	    if (_dy != 0) {
	        if (place_meeting(x, y + _dy, obj_wall)) {
	            while (!place_meeting(x, y + sign(_dy), obj_wall)) {
	                y += sign(_dy);
	                yOffset += sign(_dy);
	            }
	            fallSpeed = 0;
	        } else {
	            y += _dy;
	            yOffset += _dy;
	        }
	    }
	}
}