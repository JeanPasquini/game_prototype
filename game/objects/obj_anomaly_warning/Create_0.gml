// UI de aviso de ANOMALIA da sala.
// Fluxo: espera a cutscene de transicao sumir -> aparece titulo + descricao ->
// segura ~2.5s -> some. So depois disso o obj_wave_manager libera as hordas.

title = "";
desc  = "";

// tempos (frames, ~60fps)
fade_in  = 16;
hold     = 150;
fade_out = 28;

state = "wait";   // wait -> in -> hold -> out
t     = 0;
a     = 0;        // alpha atual
yoff  = -24;      // deslocamento vertical (slide)

title_font = fnt_ui_menu_perk_selection_title;
desc_font  = fnt_ui_menu_perk_description;

depth = -100000;  // sempre na frente

// garante que as hordas ficam seguras enquanto este aviso existir
global.anomaly_block_waves = true;

show_debug_message("[anomaly] UI criada");
