image_blend = c_red;
image_alpha = 0.5;

// cor da luz
light_color = c_white;

// intensidade
light_power = 1;

// tamanho interno (núcleo forte)
inner_scale = 0.6;

// tamanho externo (halo)
outer_scale = 1.2;


//gpu_set_blendmode(bm_add);
//draw_self();
//gpu_set_blendmode(bm_normal);
// brilho visível sempre ATRÁS dos tiles da frente (ver scr_light_layers)
scr_light_glow_behind_front_tiles(id);
