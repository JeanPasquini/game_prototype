// Inherit the parent event
//obj_menu_boss_introduction.scr_introduction(id, name, 180);
//obj_menu_boss_introduction.scr_introduction_point(x, y, name, 180);
maxDetectionRadius = 100000;
event_inherited();

// Isenta o boss dos helpers de colisao novos (unstick / flip por face_scale):
// a cutscene de apresentacao move x/y na mao e o unstick a teleportava.
is_boss = true;

