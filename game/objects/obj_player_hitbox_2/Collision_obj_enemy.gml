var dmg = instance_create_layer(x, y, "Instances", obj_damage_text);
dmg.text = "- " + string(damage);
dmg.color = c_white; 

// --- Knockback ---
var dir = point_direction(obj_player.x, obj_player.y, other.x, other.y);
other.x += lengthdir_x(knockback, dir);
other.life -= damage;

instance_destroy();