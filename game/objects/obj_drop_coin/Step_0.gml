vsp += grv;


if (abs(hsp) > 0.1) {
    hsp -= 0.02 * sign(hsp); 
} else {
    hsp = 0;
}

if (place_meeting(x + hsp, y, obj_wall) || place_meeting(x + hsp, y, obj_spike)) {
    while (!place_meeting(x + sign(hsp), y, obj_wall) && !place_meeting(x + sign(hsp), y, obj_spike)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

if (place_meeting(x, y + vsp, obj_wall) || place_meeting(x, y + vsp, obj_spike)) {
    while (!place_meeting(x, y + sign(vsp), obj_wall) && !place_meeting(x, y + sign(vsp), obj_spike)) {
        y += sign(vsp);
    }
    vsp = 0;
} else {
    y += vsp;
}
