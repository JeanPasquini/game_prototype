function shuffle_rooms() {
    randomize(); // guarantees different randomness in each Run
    var visited = ds_list_create();
    _shuffle_room(global.first_room_name, visited);
    ds_list_destroy(visited);
}

// Shuffle apenas troca posições das saídas existentes
function _shuffle_room(room_ref, visited) {
    var key = _room_key(room_ref);
    if (ds_list_find_index(visited, key) != -1) return;
    ds_list_add(visited, key);

    if (!variable_struct_exists(global.rooms_map, key)) return;
    var room_data = global.rooms_map[$ key];

    var dirs = ["up", "down", "left", "right"];

    // cria lista das direções que já têm links
    var filled_dirs = [];
    var linked_rooms = [];
    for (var i = 0; i < array_length(dirs); i++) {
        var dir = dirs[i];
        if (room_data[$ dir].link != noone) {
            array_push(filled_dirs, dir);
            array_push(linked_rooms, room_data[$ dir].link);
        }
    }

    // embaralha apenas os links existentes
    linked_rooms = array_shuffle(linked_rooms);

    // reatribui os links embaralhados às mesmas direções
    for (var i = 0; i < array_length(filled_dirs); i++) {
        var dir = filled_dirs[i];
        var new_room = linked_rooms[i];
        var old_room = room_data[$ dir].link;

        // seta novo link
        room_data[$ dir].link = new_room;

        // atualiza link reverso na room conectada
        _link_back_swap(old_room, new_room, key, dir);
    }

    // chama recursivo nas salas conectadas
    for (var i = 0; i < array_length(linked_rooms); i++) {
        _shuffle_room(linked_rooms[i], visited);
    }
}

// Atualiza a ligação reversa quando apenas trocamos links
function _link_back_swap(old_room_id, new_room_id, origin_key, dir) {
    var opp;
    switch (dir) {
        case "up": opp = "down"; break;
        case "down": opp = "up"; break;
        case "left": opp = "right"; break;
        case "right": opp = "left"; break;
        default: return;
    }

    var origin_id = _room_id_from_key(origin_key);

    // Remove ligação antiga, se existir
    if (old_room_id != noone) {
        var old_key = _room_key(old_room_id);
        if (variable_struct_exists(global.rooms_map, old_key)) {
            var old_data = global.rooms_map[$ old_key];
            if (old_data[$ opp].link == origin_id)
                old_data[$ opp].link = noone;
        }
    }

    // Seta a ligação reversa nova
    if (new_room_id != noone) {
        var new_key = _room_key(new_room_id);
        if (variable_struct_exists(global.rooms_map, new_key)) {
            var new_data = global.rooms_map[$ new_key];
            new_data[$ opp].link = origin_id;
        }
    }
}

function _room_key(room_ref) {
    if (is_string(room_ref)) return room_ref;
    return room_get_name(room_ref);
}

function _room_id_from_key(room_key) {
    return asset_get_index(room_key);
}