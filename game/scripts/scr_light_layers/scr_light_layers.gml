/// Camadas de tiles da FRENTE (nunca podem receber luz por cima). Nomes existentes em qualquer sala.
function scr_front_tile_layers() {
    return ["tl_front_environment_plants", "tl_front_floor"];
}

/// Menor depth entre as tl_front_* da sala (a mais à frente); -1 se a sala não tem nenhuma.
function scr_front_tiles_min_depth() {
    var _names = scr_front_tile_layers();
    var _min = infinity;
    for (var _i = 0; _i < array_length(_names); _i++) {
        var _l = layer_get_id(_names[_i]);
        if (_l != -1) _min = min(_min, layer_get_depth(_l));
    }
    return (_min == infinity) ? -1 : _min;
}

/// Maior depth entre as tl_front_* da sala (a mais ao fundo); -1 se a sala não tem nenhuma.
function scr_front_tiles_max_depth() {
    var _names = scr_front_tile_layers();
    var _max = -infinity;
    for (var _i = 0; _i < array_length(_names); _i++) {
        var _l = layer_get_id(_names[_i]);
        if (_l != -1) _max = max(_max, layer_get_depth(_l));
    }
    return (_max == -infinity) ? -1 : _max;
}

/// Move uma fonte de luz VISÍVEL (obj_light, obj_light_beam) para uma layer "light_glow" logo ATRÁS
/// dos tl_front_*: o brilho aditivo nunca aparece por cima dos tiles da frente, em qualquer sala,
/// não importa onde a instância foi colocada no editor.
function scr_light_glow_behind_front_tiles(_inst) {
    var _front = scr_front_tiles_max_depth();
    var _depth = (_front == -1) ? 950 : _front + 5;
    var _layer = layer_get_id("light_glow");
    if (_layer == -1) _layer = layer_create(_depth, "light_glow");
    layer_add_instance(_layer, _inst);
}


/// true se a sala atual usa iluminação (escuridão + luzes). Definido por sala no creation code:
/// global.room_lighting_enabled = false; (antes de scr_room_init). Padrão = ligada.
function scr_lighting_enabled() {
    return !variable_global_exists("lighting_on") || global.lighting_on;
}
