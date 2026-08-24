// seleção de perk é um menu bloqueante de verdade: precisa vencer a trava
// mesmo se "map" ou "status" já estiverem segurando ela (são leves e
// "try" não tomaria a trava deles) - senão o mapa/status continuam
// desenhando por cima dos cards. Mesmo padrão usado pela transição de sala.
scr_menu_lock_force("perk_selection");
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
