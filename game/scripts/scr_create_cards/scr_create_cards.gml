function scr_create_cards()
{
    // impede recriação
    if (cards_created) return;
    cards_created = true;

    cards = [];

    var sw = display_get_gui_width();
    var sh = display_get_gui_height();

    var frame_w = sprite_get_width(spr_ui_perk_selection) * 2.5;
    var spacing = frame_w + 40;

    var cx = sw * 0.5;
    var cy = sh * 0.5;

    // ===============================
    // TODOS OS PERKS POSSÍVEIS
    // ===============================
    var all_perks = [
        //obj_perk_card_damage,
        //obj_perk_card_speed_attack,
        //obj_perk_card_life,
        //obj_perk_card_restoredlife,
		//obj_perk_card_more_perks,
		obj_perk_card_fire_ring,
		obj_perk_card_rage,
		obj_perk_card_berseker,
		obj_perk_card_thunderbold,
		obj_perk_card_energy_shield,
		obj_perk_card_vampirism,
		obj_perk_card_elemental_ring
    ];

    // embaralha
    shuffle_array(all_perks);

    // ===============================
    // CRIA SOMENTE 3 (SEM REPETIR)
    // ===============================
    var perks_to_show = min(3, array_length(all_perks));

    for (var i = 0; i < perks_to_show; i++)
    {
        var xx = cx + (i - 1) * spacing;

        var card = instance_create_depth(
            xx,
            cy,
            0,
            all_perks[i]
        );

        card.index = i;
        array_push(cards, card);
    }
}

function shuffle_array(_arr)
{
    var n = array_length(_arr);
    for (var i = n - 1; i > 0; i--)
    {
        var j = irandom(i);
        var tmp = _arr[i];
        _arr[i] = _arr[j];
        _arr[j] = tmp;
    }
}
