if (!variable_global_exists("rooms_map")) {
    global.rooms_map = {
	    phase_01: {
			HUB: {
				sends: { up: safe_room },
				returns: { },
				up:    { px: 64, py: 448 },
				down:  { px: 64, py: 448 },
				left:  { px: 64, py: 448 },
				right: { px: 64, py: 448 },
			},
			safe_room: {
				sends: { left: challenge_01 },
				returns: { down: HUB },
				up:    { px: 704, py: 416 },
				down:  { px: 832, py: 448 },
				left:  { px: 224, py: 448 },
				right: { px: 976, py: 448 },
			},
			challenge_01: {
				sends: { left: challenge_02 },
				returns: { right: safe_room },
				up:    { px: 1121, py: 218 },
				down:  { px: 806, py: 432 },
				left:  { px: 32, py: 432 },
				right: { px: 1968, py: 432 },
			},
			challenge_02: {
				sends: { left: challenge_03 },
				returns: { right: challenge_01  },
				up:    { px: 563, py: 400 },
				down:  { px: 488, py: 432 },
				left:  { px: 32, py: 432 },
				right: { px: 976, py: 432 },
			},
			challenge_03: {
				sends: { },
				returns: { right: challenge_02 },
				up:    { px: 563, py: 400 },
				down:  { px: 488, py: 432 },
				left:  { px: 32, py: 432 },
				right: { px: 976, py: 432 },
			},
			next_phase: "phase_02"
		},
		
		phase_02: {}
	};
	
	global.first_room_name = HUB;
	global.current_phase = "phase_01";
	//shuffle_rooms();
}