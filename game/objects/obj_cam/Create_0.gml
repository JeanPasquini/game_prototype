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

audio_listener_set_position(0, x, y, 0);
audio_listener_set_orientation(
    0,
    0, 0, -1, 
    0, 1, 0    
);