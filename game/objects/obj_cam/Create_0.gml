target_ = obj_player;

width_ = camera_get_view_width(view_camera[0]);

height_ = camera_get_view_height(view_camera[0]);

minimap_state = 0;

persistent = true;

// follow
shake_force = 0;
shake_time  = 0;

// shake
shake_x = 0;
shake_y = 0;

// parâmetros
shake_decay_force = 0.92;
shake_decay_pos   = 0.85; // suaviza retorno (importante!)
