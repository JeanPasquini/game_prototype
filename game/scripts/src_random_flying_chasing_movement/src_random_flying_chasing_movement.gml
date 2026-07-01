function src_random_flying_chasing_movement(){
	return function () {

	    // MOVIMENTO HORIZONTAL
		var _dir = sign(obj_player.x - x)	
		
		// Evita troca muito rápida de direção caso em cima do player
		if (!place_meeting(x, obj_player.y, obj_player)) {
			if (_dir == -1) direction = 180 else direction = 0;
			
			if (currentState == EnemyState.RETREAT) {
				 direction = (direction == 0) ? 180 : 0;
			}
		}
				
		// --- Movimento horizontal com verificação de colisão ---
	    var _dx = lengthdir_x(movementSpeed, direction); // deslocamento pretendido neste step

	    // colisão horizontal
	     if (place_meeting(x + _dx, y, obj_wall)) {
	        while (!place_meeting(x + sign(_dx), y, obj_wall)) {
	            x += sign(_dx);
	        }
	        speed = 0;
	    } else {
	        speed = movementSpeed;
	    }

	    // EFEITO DE MOVIMENTO Y
	    var _gravity     = 0.08;
	    var _thrustForce = -1.4;

	    fallSpeed += _gravity;

	    if(thrustCooldown <= 0) {
	        fallSpeed = _thrustForce + random_range(-0.2,0.2);
	        thrustCooldown = irandom_range(20,40);
	    }
	    thrustCooldown--;

	   var _dy = fallSpeed;

		// Correção vertical durante perseguição
		if(currentState == EnemyState.CHASING) {
			var _directionY = sign((obj_player.y-sprite_get_height(spr_player)) - y);
			var _chaseYForce = 0.45;
			_dy += _directionY * _chaseYForce;
		} else if (currentState == EnemyState.RETREAT) {
			_dy += _thrustForce;
		}

	    // colisão vertical
	    if(_dy != 0) {
	        if(place_meeting(x,y+_dy,obj_wall)) {
	            while(!place_meeting(x,y+sign(_dy),obj_wall)) {
	                y += sign(_dy);
	            }
	            fallSpeed = 0;
	        } else {
	            y += _dy;
	        }
	    }

	    // COLISÃO COM PLAYER
	    if(currentState == EnemyState.CHASING) {
	        if(place_meeting(x,y,obj_player)) {            
	            retreatTimer = .5 * 60;
	            currentState = EnemyState.RETREAT;
	        }
	    }
	}
}