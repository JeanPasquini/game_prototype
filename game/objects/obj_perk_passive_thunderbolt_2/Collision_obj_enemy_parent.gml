if (ds_list_find_index(hit_enemies, other.id) != -1) {
	exit;
}

ds_list_add(hit_enemies, other.id);
	
other.life -= damage;
	
var dmg = instance_create_layer(other.x, other.y, "Instances", obj_damage_text);
dmg.text = "- " + string(damage);
dmg.color = c_white;

var dir = point_direction(obj_player.x, obj_player.y, other.x, other.y);