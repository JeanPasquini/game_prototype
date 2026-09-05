var rdata = undefined;

if (current_room != noone && current_phase != noone) {
	rdata = global.rooms_map[$ current_phase][$ room_get_name(current_room)];
} else {
	rdata = global.rooms_map[$ global.current_phase][$ room_get_name(room)];
}

if (is_undefined(rdata)) instance_destroy();

var connections = rdata.connections;
var destiny = noone; // data from the next room link
var position = noone; // set the direction of entry into the next room, reverse of the current door

if (instance_exists(obj_player)) {
    var p = obj_player;

    var _transition_pressed = input_door_transition_pressed();

    if (room_direction == RoomDirection.LEFT && _transition_pressed) {
        destiny = connections.left;
        position = "right";
    } else if (room_direction == RoomDirection.RIGHT && _transition_pressed) {
        destiny = connections.right;
        position = "left";
    } else if (room_direction == RoomDirection.UP && _transition_pressed) {
        destiny = connections.up;
        position = "down";
    } else if (room_direction == RoomDirection.DOWN && _transition_pressed) {
        destiny = connections.down;
        position = "up";
    }
	
	
}

if (destiny != noone && position != noone) {

    var directions = getNextRoomPxAndPy(destiny, position);

    if (!is_undefined(directions)) {

        var player_state_ok = (obj_player.state == PlayerState.IDLE
            || obj_player.state == PlayerState.WALK
            || obj_player.state == PlayerState.RUN);

        // só inicia se a porta ainda não estiver tocando a própria animação,
        // o player estiver perto (colisão), num state válido, no chão, e
        // nenhum outro menu estiver travando o mundo
        if (trans_state == "idle" && player_state_ok && obj_player.ong && !scr_menu_lock_blocks_world()) {

            // trava o mundo (isso já esconde a HUD/obj_map via obj_control)
            scr_menu_lock_force("transition");

            // fecha o mapa se estiver aberto
            obj_map.minimap_state = 0;

            // vinheta + zoom próximo do player (mesma UI da introdução de boss)
            obj_menu_boss_introduction.boss_name = "";
            obj_menu_boss_introduction.boss_introduction = true;
            obj_cam.zoom_target = 0.85;

            // a porta começa a "abrir", sincronizada com o player mais pra frente
            trans_state = "opening";

            // manda o player andar até o centro da porta antes de tocar
            // a animação de spr_player_transition
            obj_player.state = PlayerState.TRANSITION;
            obj_player.transition_phase = 0;
            obj_player.transition_target_x = x;
            obj_player.transition_destiny = destiny;
            obj_player.transition_px = directions.px;
            obj_player.transition_py = directions.py;
            obj_player.transition_is_boss_door = is_boss_door;
            obj_player.transition_room_started = false;
        }
    }
}
