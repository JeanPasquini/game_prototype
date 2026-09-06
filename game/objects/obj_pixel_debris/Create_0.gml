// Detrito de pixel gerado por scr_enemy_shatter na morte de um inimigo pequeno.
// Fisica simples: gravidade, colisao + quique em obj_wall, atrito no chao, e fade
// quando descansa. Estes defaults sao sobrescritos pelo spawner logo apos criar
// (col, chunk_size, hsp, vsp).

chunk_size = 3;
col        = c_white;

hsp = 0;
vsp = 0;

grv            = 0.35;   // gravidade por passo
bounce         = 0.42;   // fracao da velocidade mantida a cada quique
friction_floor = 0.68;   // atrito horizontal ao tocar o chao
air_drag       = 0.995;  // leve arrasto no ar

rest_frames = 0;         // passos seguidos "parado no chao"
rest_needed = 4;         // apos isso, comeca o fade

fade_len   = 16;         // duracao do fade em passos
fade_timer = -1;         // -1 = fade nao iniciado

max_life   = 260;        // salvaguarda: some mesmo se nunca "descansar"

image_alpha = 1;

// desenha por cima da maioria das instancias, mas ainda no mundo
depth = -100;

// "solido" pro detrito = parede estatica ou bloco de parede (mesma dupla que vale
// pros inimigos; ver memoria enemy-collision-rules). Nao colide com player/inimigo.
// collision_point (nao place_meeting): o detrito nao tem sprite/mascara, entao ele
// e tratado como um PONTO — mesmo padrao do scr_enemy_point_solid do projeto.
is_solid = function(_x, _y) {
    return collision_point(_x, _y, obj_wall,       false, true) != noone
        || collision_point(_x, _y, obj_wall_block, false, true) != noone;
};
