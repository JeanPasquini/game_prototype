// O erro acontece porque a orb tentou ler
// O erro acontece porque a orb tentou ler
// global.orbit_angle antes do objeto controlador criar ela.
//
// Isso acontece quando a orb executa o Step primeiro.
//
// A solução é garantir segurança no Step da orb:

//======================================
// STEP EVENT DA ORB
//======================================

// segurança do slot




if(sprite_index != spr_perk_passive_elemental_ring_ice_hitting){
	if (!variable_instance_exists(id, "orbit_slot")) {
	    orbit_slot = 0;
	}

	// segurança do total
	if (!variable_global_exists("total_orbs")) {
	    global.total_orbs = 3;
	}

	// segurança do ângulo global
	if (!variable_global_exists("orbit_angle")) {
	    global.orbit_angle = 0;
	}

	var total = global.total_orbs;
	var distancia = 40;
	var espacamento = 360 / total;

	// agora não vai mais dar erro
	var meu_angulo = global.orbit_angle + (orbit_slot * espacamento);

	// guardar posição anterior
	var old_x = x;
	var old_y = y;

	// orbitar o player
	x = obj_player.x + lengthdir_x(distancia, meu_angulo);
	y = obj_player.y + lengthdir_y(distancia, meu_angulo);

	// direção do movimento
	direction = point_direction(old_x, old_y, x, y);
	image_angle = direction + 180;
	obj_effect_unicle.scr_fx_perk_elemental_ring(x, y, $C6D100, $D15000, $D18A10);
}

