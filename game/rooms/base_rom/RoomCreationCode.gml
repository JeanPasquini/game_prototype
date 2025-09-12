if (!variable_global_exists("rooms_map")) {
    global.rooms_map = {
	    HUB: {
	        up:    { link: Room1, px: 64, py: 448 },
	        down:  { link: noone, px: 64, py: 448 },
	        left:  { link: noone, px: 64, py: 448 },
	        right: { link: noone, px: 64, py: 448 },
	    },
	      Room1: {
	        up:    { link: noone, px: 51, py: 224 },
	        down:  { link: HUB, px: 272, py: 448 },
	        left:  { link: challenge_01, px: 8, py: 448 },
	        right: { link: challenge_02, px: 992, py: 448 },
	    },
	    challenge_01: {
	        up:    { link: noone, px: 322, py: 410 },
	        down:  { link: noone, px: 155, py: 432 },
	        left:  { link: noone, px: 32, py: 432 },
	        right: { link: Room1, px: 483, py: 432 },
	    },
	    challenge_02: {
	        up:    { link: noone, px: 343, py: 400 },
	        down:  { link: noone, px: 235, py: 432 },
	        left:  { link: Room1, px: 32, py: 432 },
	        right: { link: noone, px: 504, py: 432 },
	    }
	};
	
	global.first_room_name = HUB;
	shuffle_rooms();
}