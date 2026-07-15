var _float_offset = sin(current_time / 300) * 3;
var _sway_angle = sin(current_time / 450) * 2;

image_angle = _sway_angle;

draw_sprite_ext(
	sprite_index,
	image_index,
	x,
	y + _float_offset,
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);

if(type == ShipType.FINISHING_MOVEMENT || type == ShipType.STARTING_MOVEMENT){
	if(!flag_earthquake){
		obj_earthquake.start_earthquake(1, 200);
		flag_earthquake = true;
	}
}
else if (type == ShipType.SHOOTING){
	flag_earthquake = false
}
else if (type == ShipType.FINISHING_MOVEMENT){
	if(!flag_earthquake){
		obj_earthquake.start_earthquake(1, 200);
		flag_earthquake = true;
	}
}