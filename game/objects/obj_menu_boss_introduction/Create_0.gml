boss_introduction = false;
boss_name = "";
scr_introduction = function(_boss_id, _boss_name, _time){
	obj_cam.target_ = _boss_id;
	boss_name = _boss_name;
	boss_introduction = true;
	alarm[0] = 180;
}

scr_introduction_point = function(_x, _y, _boss_name, _time) {
    obj_cam.target_ = noone;      // garante que não tá seguindo ninguém
    obj_cam.fixed_point = true;   // flag pra câmera saber que deve travar num ponto
    obj_cam.point_x = _x;
    obj_cam.point_y = _y;
    
    boss_name = _boss_name;
    boss_introduction = true;
    alarm[0] = _time;
}