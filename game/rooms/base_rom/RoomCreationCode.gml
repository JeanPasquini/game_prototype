if (!variable_global_exists("rooms_map")) {
    global.rooms_map = {
        HUB: {
            up: Room1,
            down: noone,
            left: noone,
            right: noone,
			px: 64,
			py: 448
        },
		Room1: {
            down: noone,
            up: noone,
            left: HUB,
            right: challenge_01,
			px: 100,
			py: 200
        },
        challenge_01: {
            up: noone,
            down: noone,
            left: HUB,
            right: challenge_02,
			px: 64,
			py: 448
        },
        challenge_02: {
            up: noone,
            down: noone,
            left: challenge_01,
            right: mini_boss,
			px: 100,
			py: 200
        }
    };
}
