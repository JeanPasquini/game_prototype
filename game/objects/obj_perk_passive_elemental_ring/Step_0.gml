//======================================
// OBJ CONTROLADOR
// Step Event
//======================================

// animação compartilhada do ring
ring_frame += ring_anim_speed;

var max_frames = 60;

if (ring_frame >= max_frames) {
    ring_frame = 0;
}

// total de orbs
global.total_orbs = 3;

// ângulo global de rotação
// SOMENTE O CONTROLADOR altera isso
if (!variable_global_exists("orbit_angle")) {
    global.orbit_angle = 0;
}

// velocidade da rotação
global.orbit_angle += 2;

