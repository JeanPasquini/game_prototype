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
    if (enemy_object != -1 && object_exists(enemy_object)) {
        var _enemy_layer = layer_exists("enemy") ? "enemy" : layer;
        instance_create_layer(x, y, _enemy_layer, enemy_object);
    }
}
