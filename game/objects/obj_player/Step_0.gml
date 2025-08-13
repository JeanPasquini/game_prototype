// === MOVEMENT ===

// Gravity
vsp += grv;

var hsp = 0;
if (keyboard_check(vk_right)) {
    hsp = spd;
    face = 1;
}
if (keyboard_check(vk_left)) {
    hsp = -spd;
    face = -1;
}

// Jump
if (keyboard_check_pressed(vk_up) && ong) {
    vsp = jmp;
}

// === HORIZONTAL COLLISION ===
if (place_meeting(x + hsp, y, obj_wall)) {
    while (!place_meeting(x + sign(hsp), y, obj_wall)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// === VERTICAL COLLISION ===
ong = false;
if (place_meeting(x, y + vsp, obj_wall)) {
    while (!place_meeting(x, y + sign(vsp), obj_wall)) {
        y += sign(vsp);
    }
    if (vsp > 0) ong = true;
    vsp = 0;
}
y += vsp;

// === ANIMATION ===

if (!ong) {
    sprite_index = spr_jump;
    image_speed = 0;

    if (vsp < -1) {
        image_index = 0; // start of jump
    } else if (abs(vsp) <= 1) {
        image_index = 1; // top of jump
    } else {
        image_index = 2; // falling
    }
} else {
    if (hsp != 0) {
        sprite_index = spr_run;
        image_speed = 0.2;
    } else {
        sprite_index = spr_idle;
        image_speed = 0.1;
    }
}

// Flip sprite
image_xscale = face;
