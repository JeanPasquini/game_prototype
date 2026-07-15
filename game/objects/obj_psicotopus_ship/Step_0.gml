if(!instance_exists(obj_psicotopus))instance_destroy();

scr_audio_emitter(x, y, emitterAudio);

switch (type) {
    case ShipType.STARTING_MOVEMENT:
        movement_starting();
		break;
	case ShipType.FINISHING_MOVEMENT:
        movement_finishing();
		break;
	case ShipType.SHOOTING:
        attacking();
		break;
}

function movement_starting() {
	if (orientation == 1) {
		image_xscale = 1.5;
		
		if (abs(x - 544) > movementSpeed) {
			x += min(movementSpeed, abs(544 - x)) * sign(544 - x);
		} else {
			x = 544;
		}
	}
	else if (orientation == -1) {
		image_xscale = -1.5;
		
		if (abs(x - 1216) > movementSpeed) {
			x += min(movementSpeed, abs(1216 - x)) * sign(1216 - x);
		} else {
			x = 1216;
		}
	}
	
	var _target_x = (orientation == 1) ? 544 : 1216;
	var _arrived = (x == _target_x);
	
	if (_arrived && !has_arrived) {
		has_arrived = true;
		shots_fired = 0;
		type = ShipType.SHOOTING;
	}
}

function attacking(){
	
	if (shots_fired < shots_fired_max && alarm[0] <= 0) {
		var _target_ys = [288, 330];
		var _target_y = _target_ys[irandom(1)];
	
		var b = instance_create_layer(x, _target_y, "Instances", obj_psicotopus_net_ball);
		b.direction = point_direction(x, _target_y, obj_player.x, _target_y);
	
		shots_fired++;
		alarm[0] = 60;
	}
	else if(shots_fired >= shots_fired_max){
		type = ShipType.FINISHING_MOVEMENT;
	}
}

function movement_finishing(){
	
	if (orientation == 1) {
		if (abs(x - 244) > movementSpeed) {
			x += min(movementSpeed, abs(244 - x)) * sign(244 - x);
		} else {
			x = 244;
			has_arrived_finishing = true;
		}
	}
	else if (orientation == -1) {
		if (abs(x - 1516) > movementSpeed) {
			x += min(movementSpeed, abs(1516 - x)) * sign(1516 - x);
		} else {
			x = 1516;
			has_arrived_finishing = true;
		}
	}
}