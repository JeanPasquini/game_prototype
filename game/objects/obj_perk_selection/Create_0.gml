scr_menu_lock_try("perk_selection");
layer_set_visible(layer_get_id("ui_hud_player"), false);

cards = [];
cards_created = false;

selected_index = 0;   // <<< ESSENCIAL
max_selected = 3;
selected_count = 0;

scr_perk_create_cards();
