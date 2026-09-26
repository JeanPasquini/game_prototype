// =====================================================================
// PARENT de todos os drops (obj_drop_coin, obj_drop_key, obj_drop_life...)
// Física + colisão ficam aqui (scr_drop_collision). Cada filho só define,
// no Create, o que acontece ao ser coletado:
//
//     event_inherited();
//     on_collect = function(_player) { _player.money++; };
// =====================================================================

// ===== Impulso inicial (sai "pulando" de quem dropou) =====
var _dir = irandom(360);
var _spd = random_range(1.5, 3);

hsp = lengthdir_x(_spd, _dir);
vsp = -random_range(2, 4);
grv = 0.2;

// ===== Atrito / quique =====
friction_air    = 0.02;  // mesmo atrito de antes, no ar
friction_ground = 0.12;  // no chão freia mais rápido
bounce_floor    = 0.35;  // fração do vsp devolvida ao bater no chão (0 = sem quique)
bounce_min_vsp  = 1.5;   // abaixo dessa velocidade de queda não quica mais
bounce_wall     = 0.4;   // fração do hsp devolvida ao bater numa parede
on_ground       = false;

// ===== Coleta =====
pickup_delay = 30;       // frames antes de poder ser coletado (substitui o alarm[0])

// máscara estável (igual ao obj_player): não muda com a animação nem com escala
image_xscale = 1;
image_yscale = 1;
if (sprite_index != -1) mask_index = sprite_index;

/// Sobrescreva nos filhos. Roda uma vez, na coleta, antes do instance_destroy().
on_collect = function(_player) {};
