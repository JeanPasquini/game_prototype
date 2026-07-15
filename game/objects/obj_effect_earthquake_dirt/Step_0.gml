if(obj_cam.shake_time <= 0){
	active = false;	
}

if (instance_exists(obj_cam) && active)
{
    part_emitter_stream(_ps, _pemit1, _ptype1, 1);
}
else
{
    part_emitter_stream(_ps, _pemit1, _ptype1, 0);
}

event_inherited();