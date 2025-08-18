if (!variable_global_exists("rooms_map")) {
    global.rooms_map = {
        HUB: {
            up: Room1,
            down: noone,
            left: noone,
            right: noone
        },
		Room1: {
            down: noone,
            up: noone,
            left: HUB,
            rigth: challenge_01
        },
        challenge_01: {
            up: noone,
            down: noone,
            left: HUB,
            right: challenge_02
        },
        challenge_02: {
            up: noone,
            down: noone,
            left: challenge_01,
            right: mini_boss
        }
    };
}
