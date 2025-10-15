//create a text to show the damage
var dmg = instance_create_layer(x, y, "instances", obj_damage_text);
dmg.text = "- " + string(damage);

if(!other.downed){
	other.life -= damage;
}

instance_destroy();
