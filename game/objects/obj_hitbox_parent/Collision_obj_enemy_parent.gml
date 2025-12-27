// Já foi atingido? Está invulnerável?
if (
	ds_list_find_index(hit_enemies, other.id) != -1 ||
	other.is_invencible
	) {
    exit; // já bateu nesse inimigo
}

// Marca como atingido
ds_list_add(hit_enemies, other.id);

// ======= AQUI VAI SEU CÓDIGO DE DANO ===========
var dmg = instance_create_layer(x, y, "Instances", obj_damage_text);
dmg.text = "- " + string(damage);
dmg.color = c_white;

var dir = point_direction(obj_player.x, obj_player.y, other.x, other.y);

other.knockback_x = lengthdir_x(obj_player.attack_knockback, dir);
obj_player.knockback_x = -lengthdir_x(obj_player.attack_recoil, dir);

other.life -= damage;

obj_combo_streak.combo_streak++;
obj_combo_streak.alarm[0] = 200;
// ================================================
