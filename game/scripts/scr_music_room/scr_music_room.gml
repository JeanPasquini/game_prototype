function scr_music_room() {

    if (!instance_exists(obj_control)) return;

    var phase = global.current_phase;

    var room_name = room_get_name(room);

    room_name = string_replace_all(room_name, "rm_", "");

    var phase_data = variable_struct_get(global.rooms_map, phase);

    if (!variable_struct_exists(phase_data, room_name)) {
        show_debug_message("ERRO: room '" + room_name + "' não existe no rooms_map!");
        obj_control.audio_target = noone;
        return;
    }

    var room_data = variable_struct_get(phase_data, room_name);

    if (variable_struct_exists(room_data, "music")) {
        obj_control.audio_target = room_data.music;
    } else {
        obj_control.audio_target = noone;
    }
}
