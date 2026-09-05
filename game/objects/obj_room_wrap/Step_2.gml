// End Step: aplica o wrap depois de todo movimento/colisao do frame.
var _rw = room_width;
var _rh = room_height;
var _m  = wrap_margin;

for (var i = 0; i < array_length(wrap_objs); i++) {
	with (wrap_objs[i]) {
		if (x < -_m)        x = _rw + _m;
		else if (x > _rw + _m) x = -_m;

		if (y < -_m)        y = _rh + _m;
		else if (y > _rh + _m) y = -_m;
	}
}
