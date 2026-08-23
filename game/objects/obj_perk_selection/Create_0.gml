scr_menu_lock_try("perk_selection");
layer_set_visible(layer_get_id("ui_hud_player"), false);

cards = [];
cards_created = false;

selected_index = 0;   // <<< ESSENCIAL
max_selected = 3;
selected_count = 0;

// controla a espera pela animação de saída dos cards antes de fechar o menu
confirmed        = false;
confirm_timer     = 0;
confirm_duration  = 10; // deve bater com despawn_speed do obj_perk_card_base

scr_perk_create_cards();
