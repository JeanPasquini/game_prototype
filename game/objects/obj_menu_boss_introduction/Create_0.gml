boss_introduction = false;
boss_name = "";
scr_introduction = function(_boss_id, _boss_name, _time){
	obj_cam.target_ = _boss_id;
	boss_name = _boss_name;
	boss_introduction = true;
	alarm[0] = 180;
}