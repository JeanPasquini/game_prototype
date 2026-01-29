
if (ds_list_find_index(hit_enemies, other.id) != -1) {
    exit;
}

audio_play_sound(sde_enemy_hit, 1, false);

ds_list_add(hit_enemies, other.id);

var dmg = instance_create_layer(x, y, "Instances", obj_damage_text);
dmg.text = "- " + string(damage);
dmg.color = c_white;

var dir = point_direction(obj_player.x, obj_player.y, other.x, other.y);

other.knockback_x = lengthdir_x(obj_player.attack_knockback, dir);
obj_player.knockback_x = -lengthdir_x(obj_player.attack_recoil, dir);
if(instance_exists(obj_perk_active_temporal_jump)){
        obj_perk_active_temporal_jump.mark_enemy(other);
}
if(instance_exists(obj_perk_passive_thunderbolt)) obj_perk_passive_thunderbolt.scr_perk_thunderbolt(other.x, other.y);
if(instance_exists(obj_perk_passive_vampirism)){
	if(obj_player.life + obj_perk_passive_vampirism.total_healed <= obj_player.life_max){
		var heal = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_damage_text);
			heal.text = "+ " + string(obj_perk_passive_vampirism.total_healed);
			heal.color = c_green;
		obj_player.life += obj_perk_passive_vampirism.total_healed;
	}
	else{
		obj_player.life = obj_player.life_max;	
	}
}

other.life -= damage;

obj_combo_streak.scr_combo_streak();

if (obj_player.energy < obj_player.energy_max && obj_player.perk_activatable != noone) obj_player.energy ++;
