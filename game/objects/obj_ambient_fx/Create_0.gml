/// Atmosfera de caverna: poeira, esporos luminosos e pedrinhas caindo (só formas quadradas).
/// Três sistemas de partículas em profundidades diferentes dão sensação de camadas:
///   far  (1950): atrás dos tiles, na frente do fundo  -> poeira distante
///   mid  (1250): atrás do player                       -> esporos luminosos + pedrinhas
///   near (500):  na frente de tudo do mundo            -> poeira próxima (pouca, pequena e discreta)
persistent = true;
enabled = true;   // scr_room_init liga/desliga por sala (global.room_ambient_fx_enabled no creation code)

ps_far  = part_system_create(); part_system_depth(ps_far, 1950);
ps_mid  = part_system_create(); part_system_depth(ps_mid, 1250);
ps_near = part_system_create(); part_system_depth(ps_near, 500);

// ===== poeira distante: pixels lavanda, subindo bem devagar =====
t_mote_far = part_type_create();
part_type_shape(t_mote_far, pt_shape_pixel);
part_type_size(t_mote_far, 1, 2, 0, 0);
part_type_colour2(t_mote_far, make_colour_rgb(120, 110, 170), make_colour_rgb(80, 90, 140));
part_type_alpha3(t_mote_far, 0, 0.55, 0);
part_type_speed(t_mote_far, 0.03, 0.12, 0, 0);
part_type_direction(t_mote_far, 50, 130, 0, 8);
part_type_life(t_mote_far, 400, 800);

// ===== poeira próxima: maior, mais clara e mais rápida (efeito de profundidade) =====
t_mote_near = part_type_create();
part_type_shape(t_mote_near, pt_shape_pixel);
part_type_size(t_mote_near, 1, 1.5, 0, 0);
part_type_colour2(t_mote_near, make_colour_rgb(210, 210, 245), make_colour_rgb(150, 160, 215));
part_type_alpha3(t_mote_near, 0, 0.3, 0);
part_type_speed(t_mote_near, 0.15, 0.4, 0, 0);
part_type_direction(t_mote_near, 30, 150, 0, 10);
part_type_life(t_mote_near, 250, 500);

// ===== esporos luminosos: brilho aditivo ciano/azul que oscila =====
t_spore = part_type_create();
part_type_shape(t_spore, pt_shape_square);
part_type_size(t_spore, 0.03, 0.06, 0, 0);
part_type_colour3(t_spore, make_colour_rgb(60, 220, 200), make_colour_rgb(120, 200, 255), make_colour_rgb(60, 220, 200));
part_type_alpha3(t_spore, 0, 0.75, 0);
part_type_speed(t_spore, 0.05, 0.15, 0, 0);
part_type_direction(t_spore, 70, 110, 0, 14);
part_type_life(t_spore, 300, 600);
part_type_blend(t_spore, true);

// ===== pedrinha que se solta do teto e cai =====
t_pebble = part_type_create();
part_type_shape(t_pebble, pt_shape_square);
part_type_size(t_pebble, 0.04, 0.09, 0, 0);
part_type_orientation(t_pebble, 0, 360, 4, 0, false);
part_type_colour2(t_pebble, make_colour_rgb(95, 90, 115), make_colour_rgb(60, 55, 80));
part_type_alpha2(t_pebble, 1, 0);
part_type_speed(t_pebble, 0.2, 0.6, 0, 0);
part_type_direction(t_pebble, 260, 280, 0, 0);
part_type_gravity(t_pebble, 0.07, 270);
part_type_life(t_pebble, 90, 160);

// densidade (partículas por frame por px² de view) e acumuladores
rate_mote_far  = 0.18  / 230400;
rate_mote_near = 0.025 / 230400;
rate_spore     = 0.035 / 230400;
acc_mote_far = 0; acc_mote_near = 0; acc_spore = 0;
pebble_timer = irandom_range(200, 500);

margin = 48;      // emite um pouco além da view, pra as partículas já "estarem lá" quando a câmera anda
warm   = true;    // pré-aquece no primeiro Step de cada sala (a atmosfera já nasce cheia)

/// @function emit(ps, type, count, [inside_only])
emit = function(_ps, _type, _n, _inside = false) {
    var _cam = view_camera[0];
    var _vx = camera_get_view_x(_cam), _vy = camera_get_view_y(_cam);
    var _vw = camera_get_view_width(_cam), _vh = camera_get_view_height(_cam);
    var _m = _inside ? 0 : margin;
    repeat (_n) {
        part_particles_create(_ps,
            random_range(_vx - _m, _vx + _vw + _m),
            random_range(_vy - _m, _vy + _vh + _m),
            _type, 1);
    }
};
