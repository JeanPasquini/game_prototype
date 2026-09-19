if (!instance_exists(obj_player)) exit;

// sem sprite não há máscara de colisão: a área é um retângulo centrado na instância
var _inside = (abs(obj_player.x - x) <= trigger_width / 2) && (abs(obj_player.y - y) <= trigger_height / 2);
if (!input_door_transition_pressed()) exit;

// a partir daqui o botão foi apertado: explica no Output o que impediu, se algo impedir
if (!_inside) { log("botão apertado, mas o player está FORA da área (player " + string(obj_player.x) + "," + string(obj_player.y) + " / centro da área " + string(x) + "," + string(y) + ", " + string(trigger_width) + "x" + string(trigger_height) + ")"); exit; }
if (!variable_global_exists("rooms_map") || !variable_global_exists("run_pos")) { log("sem rooms_map/run_pos"); exit; }

var _phase = global.current_phase;
var _node  = global.rooms_map[$ _phase][$ global.run_pos];
if (is_undefined(_node)) { log("sem nó do mapa pra run_pos=" + string(global.run_pos)); exit; }

// destino: primeira conexão existente do slot atual (no HUB só sobra a da primeira sala da run)
var _dirs = ["up", "right", "left", "down"];
var _opposite = { up: "down", down: "up", left: "right", right: "left" };
var _destiny_slot = noone;
var _entry_dir = noone;
for (var _i = 0; _i < array_length(_dirs); _i++) {
    if (variable_struct_exists(_node.connections, _dirs[_i])) {
        _destiny_slot = _node.connections[$ _dirs[_i]];
        _entry_dir = _opposite[$ _dirs[_i]];   // porta de entrada na sala nova (oposta)
        break;
    }
}
if (_destiny_slot == noone) { log("o slot " + string(global.run_pos) + " não tem nenhuma conexão: " + string(variable_struct_get_names(_node.connections))); exit; }

var _directions   = getNextRoomPxAndPy(_destiny_slot, _entry_dir);
var _destiny_node = global.rooms_map[$ _phase][$ _destiny_slot];
if (is_undefined(_directions) || is_undefined(_destiny_node)) { log("sem ponto de spawn/nó de destino: slot=" + string(_destiny_slot) + " dir=" + string(_entry_dir)); exit; }

var _player_state_ok = (obj_player.state == PlayerState.IDLE
    || obj_player.state == PlayerState.WALK
    || obj_player.state == PlayerState.RUN);

if (!_player_state_ok)                { log("estado do player não permite: " + string(obj_player.state)); exit; }
if (!obj_player.ong)                  { log("player não está no chão (ong=false)"); exit; }
if (scr_menu_lock_blocks_world())     { log("mundo travado por menu_lock=" + string(global.menu_lock)); exit; }
if (run_room_has_active_horde())      { log("há horda ativa na sala"); exit; }

log("disparou: destino=" + string(_destiny_slot) + " entrada=" + _entry_dir);

scr_menu_lock_force("transition");
obj_map.minimap_state = 0;

obj_menu_boss_introduction.boss_name = "";
obj_menu_boss_introduction.boss_introduction = true;
obj_cam.zoom_target = 0.85;
obj_cam.center_on_target = true;   // player no centro da tela durante a cena

with (obj_player) {
    state = PlayerState.TRANSITION;
    transition_phase = 0;
    transition_target_x = other.x;              // centro da luz
    transition_destiny = _destiny_node.room;    // asset -> room_goto
    transition_destiny_slot = _destiny_slot;    // slot  -> global.run_pos
    transition_entry_dir = _entry_dir;          // porta de entrada na sala nova
    transition_px = _directions.px;
    transition_py = _directions.py;
    transition_is_boss_door = false;
    transition_room_started = false;
    transition_hub_fall = true;                 // pulo + queda + morto antes da cutscene
    transition_fall_dying = false;
}
