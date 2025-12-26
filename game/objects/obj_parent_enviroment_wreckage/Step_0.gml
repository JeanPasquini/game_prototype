image_alpha = image_alpha - 0.01;
if(image_alpha <= 0){
	instance_destroy();	
}

image_angle += rot_spd;
rot_spd *= rot_friction;


vsp += grv;


if (abs(hsp) > 0.1) {
    hsp -= 0.02 * sign(hsp); 
} else {
    hsp = 0;
}

if (place_meeting(x + hsp, y, obj_wall)){
    while (!place_meeting(x + sign(hsp), y, obj_wall)) {
        x += sign(hsp);
    }
    hsp = 0;
	rot_spd *= 0.6;

}
x += hsp;

if (place_meeting(x, y + vsp, obj_wall)) {
    while (!place_meeting(x, y + sign(vsp), obj_wall)) {
        y += sign(vsp);
    }
    vsp = 0;
	rot_spd *= 0.6;

} else {
    y += vsp;
}
