/// scr_music_room()
function scr_music_room() {
    if (!instance_exists(obj_control)) return;

    // Se tiver uma música forçada, usa ela e ignora o rooms_map
    if (variable_global_exists("force_music") && global.force_music != noone) {
        obj_control.audio_target = global.force_music;
        return;
    }

    if (!variable_global_exists("rooms_map") || !variable_global_exists("run_pos")) {
        obj_control.audio_target = noone;
        return;
    }

    var phase = global.current_phase;
    var slot  = global.run_pos;
    var phase_data = variable_struct_get(global.rooms_map, phase);

    if (is_undefined(phase_data) || !variable_struct_exists(phase_data, slot)) {
        obj_control.audio_target = noone;
        return;
    }

    var room_data = variable_struct_get(phase_data, slot);
    if (variable_struct_exists(room_data, "music")) {
        obj_control.audio_target = room_data.music;
    } else {
        obj_control.audio_target = noone;
    }
}
