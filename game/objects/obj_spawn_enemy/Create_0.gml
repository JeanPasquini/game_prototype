// Marcador de ponto de spawn de inimigo para o sistema de hordas.
// Coloque instâncias na sala e configure, em cada uma:
//   enemy_type   -> qual inimigo nasce aqui (lista no editor de sala)
//   wave_number  -> em qual horda esse spawn acontece
//   warning_time -> frames de aviso antes do inimigo nascer

// garante um coordenador de hordas na sala
if (!instance_exists(obj_wave_manager)) {
    var _ctrl_layer = layer_exists("controls") ? "controls" : layer;
    instance_create_layer(x, y, _ctrl_layer, obj_wave_manager);
}

// enemy_type é uma lista (dropdown) no editor de sala: guarda o objeto direto
enemy_object   = is_string(enemy_type) ? asset_get_index(enemy_type) : enemy_type;
has_spawned    = false;
warning_active = false;
warn_timer     = 0;
warn_pulse     = 0;

image_speed = 0;

// =====================================================================
// FX DE SURGIMENTO (ajuste tudo por aqui)
// =====================================================================
// SOM: troque o(s) asset(s) abaixo pelo som da sua preferência.
// Pode deixar vários que ele sorteia um a cada spawn. Array vazio [] = sem som.
spawn_sfx = [ sde_enemy_bibipig_puff ];

// FUMAÇA
spawn_smoke_sprite = spr_dirt2; // sprite da partícula de fumaça
spawn_smoke_count  = 44;        // quantas partículas saem no estouro
spawn_smoke_xrange = 14;        // espalhamento horizontal do estouro (px)
spawn_smoke_yrange = 9;         // espalhamento vertical do estouro (px)
spawn_smoke_yoff   = 0;         // deslocamento vertical do estouro (px, - = mais pra cima)

// emissor de áudio posicional (mesmo esquema dos inimigos)
emitterAudio = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance);
audio_emitter_falloff(emitterAudio, 150, camera_get_view_width(view_camera[0]), 1);

// sistema de partículas dedicado, preso a uma camada de efeito da sala
var _fx_layer = layer_exists("effect_front") ? "effect_front"
             : (layer_exists("effect_back") ? "effect_back"
             : (layer_exists("Instances")   ? "Instances" : layer));

spawn_ps = part_system_create();
part_system_layer(spawn_ps, _fx_layer);
part_system_draw_order(spawn_ps, true);

spawn_pt = part_type_create();
part_type_sprite(spawn_pt, spawn_smoke_sprite, false, false, true);
part_type_size(spawn_pt, 0.28, 0.6, 0.015, 0); // partículas pequenas (bem "pixel")
part_type_scale(spawn_pt, 1, 1);               // escala normal
part_type_speed(spawn_pt, 0.6, 2.4, -0.04, 0); // sai forte e desacelera
part_type_direction(spawn_pt, 50, 130, 0, 0);  // leque pra cima, um pouco mais aberto
part_type_gravity(spawn_pt, 0.03, 270);        // puxa levemente pra baixo (assenta)
part_type_orientation(spawn_pt, 0, 359, 0, 0, false);
part_type_colour3(spawn_pt, $E8E8E8, $B0B0B0, $868686);
part_type_alpha3(spawn_pt, 1, 0.6, 0);
part_type_blend(spawn_pt, false);
part_type_life(spawn_pt, 30, 55);

// estoura a fumaça neste ponto
function spawn_fx_smoke() {
    if (!part_system_exists(spawn_ps)) return;
    var _px = x;
    var _py = y + spawn_smoke_yoff;
    repeat (spawn_smoke_count) {
        var _ox = _px + random_range(-spawn_smoke_xrange, spawn_smoke_xrange);
        var _oy = _py + random_range(-spawn_smoke_yrange, spawn_smoke_yrange);
        part_particles_create(spawn_ps, _ox, _oy, spawn_pt, 1);
    }
}

// toca o som de surgimento neste ponto
function spawn_fx_sound() {
    if (array_length(spawn_sfx) == 0) return;
    audio_emitter_position(emitterAudio, x, y, 0);
    scr_audio_play(spawn_sfx, emitterAudio);
}

// dispara a fase de aviso; chamado pelo obj_wave_manager
function begin_warning() {
    if (has_spawned || warning_active) return;
    warning_active = true;
    warn_timer     = warning_time;
}

// cria o inimigo e encerra o aviso
function do_spawn() {
    warning_active = false;
    has_spawned    = true;

    // efeito de surgimento antes do inimigo aparecer
    spawn_fx_smoke();
    spawn_fx_sound();

    if (enemy_object != -1 && object_exists(enemy_object)) {
        var _enemy_layer = layer_exists("enemy") ? "enemy" : layer;
        instance_create_layer(x, y, _enemy_layer, enemy_object);
    }
}
