surf = noone;
surf_light = -1;
surf_color = -1;


surf_mask = noone;   // silhueta dos tl_front_* (tiles da frente nunca recebem luz)

// A escuridão desenha numa layer PRÓPRIA, criada por código, sempre na frente dos tl_front_* (escurece
// tudo que está atrás dela). Independe de onde "ilumination"/"perk_in_run" estão no editor da room.
// depth 600 = padrão; se algum tl_front_* estiver mais à frente que isso, fica 5 na frente dele.
var _front_min = scr_front_tiles_min_depth();
var _dark_depth = (_front_min == -1) ? 600 : min(600, _front_min - 5);
var _dark_layer = layer_get_id("light_darkness");
if (_dark_layer == -1) _dark_layer = layer_create(_dark_depth, "light_darkness");
layer_add_instance(_dark_layer, id);
