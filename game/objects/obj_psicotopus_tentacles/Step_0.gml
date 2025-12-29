_scale_animation();


var centro_x = room_width / 2;
var centro_y = room_height / 2;

x = centro_x + lengthdir_x(radius, angle_offset + angle_rotation);
y = centro_y + lengthdir_y(radius, angle_offset + angle_rotation);

// Tangenciando o raio, para ser perpendicular ao Raio somar 90
image_angle = angle_offset + angle_rotation + 90; 

if (scale_current >= scale_target) {
	angle_rotation += movementSpeed;
}


function _scale_animation() {
	scale_current = lerp(scale_current, scale_target, grow_smoothness);
	image_yscale = scale_current;

	// Opcional: para quando estiver muito próximo
	if (abs(scale_current - scale_target) < 0.01) {
	    scale_current = scale_target;
	}
}