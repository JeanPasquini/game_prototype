// O ideal é cada orb receber um "slot fixo"
// Exemplo com 3 orbs:
//
// Fire  = slot 0
// Ice   = slot 1
// Venom = slot 2
//
// Assim mesmo se um quebrar e voltar,
// ele sempre retorna para a mesma posição.

//======================================
// OBJ CONTROLADOR
// Create Event
//======================================

ring_frame = 0;
ring_anim_speed = 1;

// total de orbs
global.total_orbs = 3;

// cria cada orb já com slot fixo
var fire = instance_create_layer(
    obj_player.x,
    obj_player.y,
    "perk_in_run",
    obj_perk_passive_elemental_ring_fire
);
fire.orbit_slot = 0;

var ice = instance_create_layer(
    obj_player.x,
    obj_player.y,
    "perk_in_run",
    obj_perk_passive_elemental_ring_ice
);
ice.orbit_slot = 1;

var venom = instance_create_layer(
    obj_player.x,
    obj_player.y,
    "perk_in_run",
    obj_perk_passive_elemental_ring_venomous
);
venom.orbit_slot = 2;

