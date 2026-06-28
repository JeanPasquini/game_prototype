function src_random_flying_chasing_movement(){
	return function () {

	    // ==========================
	    // MOVIMENTO HORIZONTAL
	    // ==========================

		var _dir = (x - obj_player.x < 0) ? 1 : -1;

		if (currentState == EnemyState.RETREAT) _dir = _dir * -1;

	    var _dx = abs(x - obj_player.x);

	    // colisão horizontal
	    if(place_meeting(x + _dx,y,obj_wall)) {
	        while(!place_meeting(x + sign(_dx),y,obj_wall)) {
	            x += sign(_dx);
	        }
			
	        // se estava atacando ou recuando inverte e entra em recuo
	        if(currentState == EnemyState.CHASING) {
	            direction += 180;
	            retreatTimer = 20;
	            currentState = EnemyState.RETREAT;
	        } else {
	            direction = (direction == 0) ? 180 : 0;
	        }
	        speed = 0;
	    } else {
	        x += movementSpeed;
	    }

	    // ==========================
	    // EFEITO DE MOVIMENTO Y
	    // ==========================
	    var _gravity     = 0.08;
	    var _thrustForce = -1.4;
	    var _maxDrop     = 10;

	    fallSpeed += _gravity;

	    if(yOffset >= _maxDrop || thrustCooldown <= 0) {
	        fallSpeed = _thrustForce + random_range(-0.3,0.3);
	        thrustCooldown = irandom_range(20,40);
	    }
	    thrustCooldown--;

	    var _randomY = (random(1)-0.5)*0.4;
		var _dy = fallSpeed + _randomY;

		// Correção vertical durante perseguição
		if(currentState == EnemyState.CHASING) {
			var _player = instance_nearest(x,y,obj_player);

			var _directionY = sign(_player.y - y);
			var _chaseYForce = 0.15;
			_dy += _directionY * _chaseYForce;
		}

	    if(yOffset + _dy > maxOffsetDown) {
	        _dy = maxOffsetDown-yOffset;
	        fallSpeed = 0;
	    } else if(yOffset + _dy < -maxOffsetUp) {
	        _dy = -maxOffsetUp-yOffset;
	        fallSpeed = 0;
	    }

	    // colisão vertical
	    if(_dy != 0) {
	        if(place_meeting(x,y+_dy,obj_wall)) {
	            while(!place_meeting(x,y+sign(_dy),obj_wall)) {
	                y += sign(_dy);
	                yOffset += sign(_dy);
	            }
	            fallSpeed = 0;
	        } else {
	            y += _dy;
	            yOffset += _dy;
	        }
	    }

	    // ==========================
	    // COLISÃO COM PLAYER
	    // ==========================
	    if(currentState == EnemyState.CHASING) {

	        if(place_meeting(x,y,obj_player)) {
	            direction += 180;
	            retreatTimer = 30;
	            currentState = EnemyState.RETREAT;
	        }
	    }
	}
}