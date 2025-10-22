if (!variable_global_exists("rooms_map")) {
    global.rooms_map = {
	    HUB: {
	        up:    { link: safe_room, px: 64, py: 448 },
	        down:  { link: noone, px: 64, py: 448 },
	        left:  { link: noone, px: 64, py: 448 },
	        right: { link: noone, px: 64, py: 448 },
	    },
	      safe_room: {
	        up:    { link: noone, px: 976, py: 432 },
	        down:  { link: noone, px: 601, py: 432 },
	        left:  { link: noone, px: 976, py: 432 },
	        right: { link: challenge_01, px: 976, py: 432 },
	    },
	    challenge_01: {
	        up:    { link: noone, px: 1121, py: 218 },
	        down:  { link: noone, px: 806, py: 432 },
	        left:  { link: safe_room, px: 32, py: 432 },
	        right: { link: challenge_02, px: 1968, py: 432 },
	    },
	    challenge_02: {
	        up:    { link: noone, px: 563, py: 400 },
	        down:  { link: noone, px: 488, py: 432 },
	        left:  { link: challenge_01, px: 32, py: 432 },
	        right: { link: challenge_03, px: 976, py: 432 },
	    },
		challenge_03: {
	        up:    { link: noone, px: 563, py: 400 },
	        down:  { link: noone, px: 488, py: 432 },
	        left:  { link: challenge_02, px: 32, py: 432 },
	        right: { link: noone, px: 976, py: 432 },
	    }
	};
	
	global.first_room_name = safe_room;
	shuffle_rooms();
}