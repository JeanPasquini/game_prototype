telegraph = noone;
alarm[0] = obj_tentacle_telegraph.telegraph_timer_base;
var bubbles_effect = instance_create_layer(x, y, "Instances", obj_effect_tentacles_bubbles)
bubbles_effect.obj_followed = id;
bubbles_effect.alarm[0] = (obj_tentacle_telegraph.telegraph_timer_base / 60) * 1000;