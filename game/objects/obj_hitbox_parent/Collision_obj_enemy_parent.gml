attack_hit_confirmed = false;

if (other.is_invencible) exit;

if (hit_enemies_bool)
{
    if (ds_exists(hit_enemies, ds_type_list))
    {
        if (ds_list_find_index(hit_enemies, other.id) != -1)
            exit;

        ds_list_add(hit_enemies, other.id);
    }
}

attack_hit_confirmed = true;

// Já foi atingido? Está invulnerável?
//if (
//	scr_already_hit_object(hit_enemies, other.id) ||
//	other.is_invencible
//	) {
//    exit; // já bateu nesse inimigo
//}

damage_total = damage;

//PERKS

if(instance_exists(obj_perk_passive_berseker)) damage_total = damage * obj_perk_passive_berseker.damage_multiplication;
if(instance_exists(obj_perk_passive_rage)) damage_total = damage_total * obj_perk_passive_rage.damage;
if(instance_exists(obj_perk_active_temporal_jump)){if(!obj_perk_active_temporal_jump.fx_active)obj_perk_active_temporal_jump.mark_enemy(other);}
if(instance_exists(obj_perk_passive_vampirism))obj_perk_passive_vampirism.healed(damage_total);

var dmg = instance_create_layer(other.x, other.y, "Instances", obj_damage_text);
dmg.text = "- " + string(damage_total);
dmg.color = c_white;
other.life -= damage_total;
obj_combo_streak.scr_combo_streak();
other.alpha = 1;
