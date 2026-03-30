// Inherit the parent event
event_inherited();

idle_movement_script = src_basic_idle_movement();
chasing_movement_script = src_basic_idle_movement();
chasing_attack_script = function () {}; // guarantees only damage from contact.