target_ = obj_player;
width_ = camera_get_view_width(view_camera[0]);
height_ = camera_get_view_height(view_camera[0]);
base_width_ = width_;
base_height_ = height_;
zoom_target = 1;
zoom_punch  = 0;   // recuo de zoom aditivo (decai sozinho) — usado na aterrissagem
fall_look   = 0;   // deslocamento vertical da câmera enquanto cai (look-ahead)
minimap_state = 0;
persistent = true;
shake_force = 0;
shake_time  = 0;
shake_x = 0;
shake_y = 0;
shake_decay_force = 0.92;
shake_decay_pos   = 0.85;

// ===== NOVO: modo de ponto fixo (introdução de boss) =====
fixed_point = false;
point_x = 0;
point_y = 0;

// ===== NOVO: centraliza exatamente no alvo (transição de porta) =====
// enquanto true, o player fica no centro exato da tela (sem o offset vertical
// normal do follow). obj_door liga; obj_transiction desliga ao abrir a sala nova.
center_on_target = false;
center_lerp = 0.15;

// ===== Trava temporária ao levar dano (Hollow Knight "focus") =====
hurt_hold     = 0;   // frames restantes com a câmera congelada no lugar
hurt_hold_max = 18;

// ===== Olhar pra cima/baixo (segurar analogico parado, estilo Hollow Knight) =====
look_offset   = 0;   // deslocamento vertical atual da camera (lerp)
look_hold     = 0;   // frames segurando o analogico numa direcao valida
look_hold_max = 28;  // precisa segurar ~0.5s parado antes da camera se mexer
look_max      = 64;  // quanto a camera desloca (px) quando o olhar esta pleno

audio_listener_set_position(0, x, y, 0);
audio_listener_set_orientation(
    0,
    0, 0, -1, 
    0, 1, 0    
);