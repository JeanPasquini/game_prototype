target_ = obj_player;

width_ = camera_get_view_width(view_camera[0]);

height_ = camera_get_view_height(view_camera[0]);

minimap_state = 0;

persistent = true;

shake_force = 0;
shake_time  = 0;

shake_x = 0;
shake_y = 0;

shake_decay_force = 0.92;
shake_decay_pos   = 0.85;

audio_listener_set_position(0, x, y, 0);
audio_listener_set_orientation(
    0,
    0, 0, -1, 
    0, 1, 0    
);