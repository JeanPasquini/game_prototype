// Mapa da RUN indexado por chave de slot. A porta le o slot ATUAL em
// global.run_pos e suas conexoes dao os slots de destino.

if (!variable_global_exists("rooms_map") || !variable_global_exists("run_pos")) exit;

var _phase = (current_room != noone && current_phase != noone) ? current_phase : global.current_phase;
var _key   = (current_room != noone && current_phase != noone) ? current_room  : global.run_pos;

var rdata = global.rooms_map[$ _phase][$ _key];
if (is_undefined(rdata)) { instance_destroy(); exit; }

var connections  = rdata.connections;
var destiny_slot = noone; // slot de destino
var position     = noone; // direcao de entrada na sala nova (oposta a desta porta)

if (instance_exists(obj_player) && input_door_transition_pressed()) {

    if (room_direction == RoomDirection.LEFT && variable_struct_exists(connections, "left")) {
        destiny_slot = connections.left;  position = "right";
    } else if (room_direction == RoomDirection.RIGHT && variable_struct_exists(connections, "right")) {
        destiny_slot = connections.right; position = "left";
    } else if (room_direction == RoomDirection.UP && variable_struct_exists(connections, "up")) {
        destiny_slot = connections.up;    position = "down";
    } else if (room_direction == RoomDirection.DOWN && variable_struct_exists(connections, "down")) {
        destiny_slot = connections.down;  position = "up";
    }
}

if (destiny_slot != noone && position != noone) {

    var directions   = getNextRoomPxAndPy(destiny_slot, position);
    var destiny_node = global.rooms_map[$ _phase][$ destiny_slot];

    if (!is_undefined(directions) && !is_undefined(destiny_node)) {

        var player_state_ok = (obj_player.state == PlayerState.IDLE
            || obj_player.state == PlayerState.WALK
            || obj_player.state == PlayerState.RUN);

        // portas travadas enquanto houver hordas na sala
        if (trans_state == "idle" && player_state_ok && obj_player.ong
            && !scr_menu_lock_blocks_world() && !run_room_has_active_horde()) {

            scr_menu_lock_force("transition");
            obj_map.minimap_state = 0;

            obj_menu_boss_introduction.boss_name = "";
            obj_menu_boss_introduction.boss_introduction = true;
            obj_cam.zoom_target = 0.85;
            obj_cam.center_on_target = true; // player no centro da tela durante a animação

            trans_state = "opening";

            obj_player.state = PlayerState.TRANSITION;
            obj_player.transition_phase = 0;
            obj_player.transition_target_x = x;
            obj_player.transition_destiny = destiny_node.room; // asset -> room_goto
            obj_player.transition_destiny_slot = destiny_slot; // slot  -> global.run_pos
            obj_player.transition_entry_dir = position;        // porta de entrada na sala nova
            obj_player.transition_px = directions.px;
            obj_player.transition_py = directions.py;
            obj_player.transition_is_boss_door = is_boss_door;
            obj_player.transition_room_started = false;
        }
    }
}
