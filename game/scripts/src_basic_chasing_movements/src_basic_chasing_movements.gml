function src_basic_chasing_movements(_target, _spd) {
    direction = point_direction(x, y, _target.x, y);
	var _target_bottom = _target.sprite_height/2;
	
	var _dir = 0;
	if (direction == 180) _dir = -1  else if (direction == 0) _dir = 1
	
	if (place_meeting(x + (sprite_width * _dir), y, obj_wall)) { // Verifica futura colisão com parede
		
		show_debug_message("parede");
		if (currentMovement == EnemyState.ONGROUND) {
			currentMovement = EnemyState.JUMPING;
		}
		
	} else if (!place_meeting(x + (sprite_width * _dir), y + 1, obj_wall)) { // Verifica se ficará sem chão
		show_debug_message("sem chao");
		if ((_target.y + _target_bottom) - y > 0) {
			currentMovement = EnemyState.FALLING;
		} else if ((_target.y + _target_bottom) - y < 0) {
			currentMovement = EnemyState.JUMPING;
		}
		
	}  else {
		currentMovement = EnemyState.ONGROUND;
	}
	
	
	if (currentMovement == EnemyState.JUMPING) {
			show_debug_message("subindo");
			 // Distâncias entre inimigo e player
		    var dx = _target.x - x;
		    var dy = _target.y - y;
		
			dy -= 60;

		    // Velocidade inicial do salto (ajuste conforme necessidade)
		    var v0 = 1; 
		    var g  = 0.0005; // gravidade (precisa estar definida no objeto)

		    // Estimativa do tempo de voo até o player
		    // (se não quiser precisão física, pode usar tempo fixo tipo 30 frames)
		    var t = 60; 

		    // Calcula velocidade horizontal necessária
		    hspeed = dx / t;

		    // Calcula velocidade vertical necessária para alcançar o player
		    vspeed = (dy - 0.5 * g * t * t) / t;
	} else if (currentMovement = EnemyState.FALLING) {
			show_debug_message("descendo");
			// Distâncias entre inimigo e player
			var dx = _target.x - x;
			var dy = _target.y - y;
		
			dy += 60;

			// Velocidade inicial do salto (ajuste conforme necessidade)
			var v0 = 1; 
			var g  = 0.0005; // gravidade (precisa estar definida no objeto)

			// Estimativa do tempo de voo até o player
			// (se não quiser precisão física, pode usar tempo fixo tipo 30 frames)
			var t = 60; 

			// Calcula velocidade horizontal necessária
			hspeed = dx / t;

			// Calcula velocidade vertical necessária para alcançar o player
			vspeed = (dy + 0.5 * g * t * t) / t;
			
	} else {
		currentMovement = EnemyState.ONGROUND;
		show_debug_message("condicao normal");
		speed = _spd;
	}
			
}
