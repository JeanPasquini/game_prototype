if (!scr_lighting_enabled()) exit;   // sala com iluminação desligada

gpu_set_blendmode(bm_add);
draw_self();
gpu_set_blendmode(bm_normal);
