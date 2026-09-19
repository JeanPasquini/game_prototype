if (!enabled) exit;   // sala com a atmosfera desligada: não emite nada (o Room Start já limpou as partículas)

var _cam = view_camera[0];
var _vx = camera_get_view_x(_cam), _vy = camera_get_view_y(_cam);
var _vw = camera_get_view_width(_cam), _vh = camera_get_view_height(_cam);
var _area = (_vw + margin * 2) * (_vh + margin * 2);

// sala nova: enche a tela de uma vez
if (warm) {
    warm = false;
    emit(ps_far,  t_mote_far,  90, true);
    emit(ps_near, t_mote_near, 12, true);
    emit(ps_mid,  t_spore,     16, true);
}

// emissão contínua (acumula fração por frame)
acc_mote_far  += _area * rate_mote_far;
acc_mote_near += _area * rate_mote_near;
acc_spore     += _area * rate_spore;

if (acc_mote_far  >= 1) { emit(ps_far,  t_mote_far,  floor(acc_mote_far));  acc_mote_far  -= floor(acc_mote_far); }
if (acc_mote_near >= 1) { emit(ps_near, t_mote_near, floor(acc_mote_near)); acc_mote_near -= floor(acc_mote_near); }
if (acc_spore     >= 1) { emit(ps_mid,  t_spore,     floor(acc_spore));     acc_spore     -= floor(acc_spore); }

// pedrinha ocasional caindo do topo da tela
pebble_timer--;
if (pebble_timer <= 0) {
    part_particles_create(ps_mid, random_range(_vx, _vx + _vw), _vy - 4, t_pebble, 1);
    pebble_timer = irandom_range(300, 720);
}
