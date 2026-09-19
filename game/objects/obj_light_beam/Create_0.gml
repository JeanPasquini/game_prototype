/// Feixe de luz colocado direto na room. Funciona como o obj_light: desenha a si mesmo em blend
/// aditivo (Draw) e também entra no mapa de luz do obj_controla_luz.
///
/// No editor da room: a COR do feixe é a "Colour" da instância (image_blend); o alpha dessa cor
/// multiplica a opacidade base. Tamanho e rotação = scale/rotation da instância.
/// O feixe sempre fica atrás dos tiles da frente (scr_light_glow_behind_front_tiles).

light_color = image_blend;        // cor escolhida no editor (o mapa de luz do obj_controla_luz usa esta)
image_alpha = image_alpha * 0.5;  // opacidade base 0.5 (alpha da Colour da instância escala isso)

// brilho visível sempre ATRÁS dos tiles da frente (ver scr_light_layers)
scr_light_glow_behind_front_tiles(id);
