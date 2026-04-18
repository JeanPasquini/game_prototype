if (!variable_global_exists("rooms_map")) {
    global.rooms_map = {
	    phase_01: {
			HUB: {
				sends: { safe_room },
				connections: { up: safe_room },
				returns: false,
				music: sdt_hub,
				up:    { px: 45, py: 336 },
				down:  { px: 45, py: 336 },
				left:  { px: 45, py: 336 },
				right: { px: 45, py: 336 },
			},
			safe_room: {
				sends: { challenge_01 },
				connections: { left: challenge_01 },
				returns: false,
				music: sdt_phase1,
				up:    { px: 800, py: 480 },
				down:  { px: 800, py: 480 },
				left:  { px: 800, py: 480 },
				right: { px: 800, py: 480 },
			},
			store_room: {
				sends: { },
				connections: { down: challenge_02 },
				returns: true,
				music: sdt_phase1,
				up:    { px: 563, py: 448 },
				down:  { px: 488, py: 453 },
				left:  { px: 32, py: 453 },
				right: { px: 976, py: 453 },
			},
			challenge_01: {
				sends: { challenge_02 },
				connections: { left: challenge_02, right: safe_room },
				returns: true,
				music: sdt_phase1,
				up:    { px: 1088, py: 293 },
				down:  { px: 576, py: 741 },
				left:  { px: 352, py: 357 },
				right: { px: 1568, py: 709 },
			},
			challenge_02: {
				sends: { challenge_03, store_room },
				connections: { left: challenge_03, right: challenge_01, up: store_room },
				returns: true,
				music: sdt_phase1,
				up:    { px: 563, py: 416 },
				down:  { px: 488, py: 448 },
				left:  { px: 32, py: 432 },
				right: { px: 976, py: 432 },
			},
			challenge_03: {
				sends: { mini_boss_01 },
				connections: { right: challenge_02, down: mini_boss_01 },
				returns: true,
				music: sdt_phase1,
				up:    { px: 563, py: 416 },
				down:  { px: 488, py: 448 },
				left:  { px: 32, py: 432 },
				right: { px: 976, py: 432 },
			},
			mini_boss_01: {
				sends: { phase_02: safe_room },
				connections: { },
				returns: false,
				music: sdt_phase1_mini_boss,
				up:    { px: 200, py: 350 },
				down:  { px: 200, py: 350 },
				left:  { px: 200, py: 350 },
				right: { px: 200, py: 350 },
			},
			
			next_phase: "phase_02"
		},
		
		phase_02: {
			safe_room: {
				sends: { challenge_04 },
				connections: { right: challenge_04 },
				returns: false,
				up:    { px: 704, py: 416 },
				down:  { px: 832, py: 448 },
				left:  { px: 224, py: 448 },
				right: { px: 976, py: 448 },
			},
			store_room: {
				sends: { },
				connections: { up: challenge_06 },
				returns: true,
				up:    { px: 563, py: 448 },
				down:  { px: 488, py: 453 },
				left:  { px: 32, py: 453 },
				right: { px: 976, py: 453 },
			},
			challenge_04: {
				sends: { challenge_05 },
				connections: { left: safe_room, right: challenge_05 },
				returns: true,
				up:    { px: 563, py: 400 },
				down:  { px: 488, py: 432 },
				left:  { px: 32, py: 432 },
				right: { px: 976, py: 432 },
			},
			challenge_05: {
				sends: { challenge_06 },
				connections: { left: challenge_04, right: challenge_06 },
				returns: true,
				up:    { px: 563, py: 400 },
				down:  { px: 488, py: 432 },
				left:  { px: 32, py: 432 },
				right: { px: 976, py: 432 },
			},
			challenge_06: {
				sends: { mini_boss_02, store_room  },
				connections: { left: challenge_05, right: mini_boss_02, down: store_room },
				returns: true,
				up:    { px: 563, py: 400 },
				down:  { px: 488, py: 432 },
				left:  { px: 32, py: 432 },
				right: { px: 976, py: 432 },
			},
			mini_boss_02: {
				sends: { last_phase: final_boss },
				connections: { },
				returns: false,
				up:    { px: 419, py: 408 },
				down:  { px: 687, py: 432 },
				left:  { px: 32, py: 432 },
				right: { px: 976, py: 432 },
			},
			
			next_phase: "last_phase"
		},
		
		last_phase: {
			final_boss: {
				sends: { phase_01: HUB },
				connections: { },
				returns: false,
				up:    { px: 419, py: 408 },
				down:  { px: 687, py: 432 },
				left:  { px: 32, py: 432 },
				right: { px: 976, py: 432 },
			},
			
			next_phase: "phase_01"
		}
	};
	
	/* 
	@global.first_room_name
	Does not change the game's starting room
	as GameMaker defaults to the room with the highest priority. 
	*/
	global.first_room_name = HUB;
	global.current_phase = "phase_01";
	shuffle_rooms();
}