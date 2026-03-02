life -= poison_damage;
obj_combo_streak.scr_combo_streak();
var dmg = instance_create_layer(other.x, other.y, "Instances", obj_damage_text);
dmg.text = "- " + string(poison_damage);
dmg.color = c_white;
alarm[3] = 100;