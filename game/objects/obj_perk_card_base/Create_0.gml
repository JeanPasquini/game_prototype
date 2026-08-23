// Visual padrão
spr_frame = spr_ui_perk_selection;
spr_icon  = noone;

title_text = "";
desc_text  = "";

ui_scale = 2.5;
size_frame_icon = 24;

// Estado
index = 0;
selected = false;
confirm_select = false;

// Fontes
font_title = fnt_ui_menu_perk_selection_title;
font_desc  = fnt_ui_menu_perk_selection_description;

// animação de seleção
select_time = 0;

// animação de entrada/saída (igual ao menu de status do obj_player)
spawn_anim_t   = 0; // 0 -> 1 ao aparecer
despawning     = false;
despawn_anim_t = 1; // 1 -> 0 ao sumir
despawn_speed  = 1 / 10;

//depth = -1;