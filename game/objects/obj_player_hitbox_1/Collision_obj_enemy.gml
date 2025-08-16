var dmg = instance_create_layer(x, y, "Instances", obj_damage_text);
dmg.text = "- " + string(damage);
dmg.color = c_white; 

instance_destroy();