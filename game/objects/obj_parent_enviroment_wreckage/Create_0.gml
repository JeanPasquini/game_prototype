sprite_index = noone;
image_index = 0;
image_speed = 0;

var dir = irandom(360);      
var spd = random_range(1, 1.5);  

hsp = lengthdir_x(spd, dir);
vsp = -random_range(2, 4);

grv = 0.2; 

// rotação
image_angle = irandom(360);
rot_spd = random_range(-8, 8);
rot_friction = 0.95;
