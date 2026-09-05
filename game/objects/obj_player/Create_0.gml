// A MÁSCARA DE COLISÃO tem que ser ESTÁVEL frame a frame (o que travava era ela
// mudar de tamanho/espelhar). Então:
//  - image_xscale = 1 SEMPRE: nunca escala nem espelha a máscara na horizontal
//    (o flip visual é feito no draw_sprite_ext via "face").
//  - image_yscale = 1.15 CONSTANTE: escala vertical fixa, só pra casar a altura
//    da máscara com o visual (que é desenhado a 1.15). Nunca é reescrito.
//  - mask_index fixo: a máscara não muda com a animação.
image_xscale = 1;
image_yscale = 1.15;
mask_index   = spr_player_idle;

// Levanta o sprite alguns px SÓ NO DESENHO, pra os pés não afundarem no chão.
// Puramente visual — não mexe na colisão.
foot_lift = 0;

// States
enum PlayerState {
    IDLE,
	WALK,
	WALK_TURN,
    RUN,
    RUN_TURN,
    RUN_TO_IDLE,
    JUMP,
	RUN_JUMP,
    FALL,
	RUN_FALL,
	SWIN,
	ATTACK,
	TALKING,
	WAIT,
	WAIT_ATTACK,
	DYING,
	DASH,
	INTRODUCTION,
	TRANSITION
}
state = PlayerState.IDLE;

// Movement
hsp = 0;
face = 1;
vsp = 0;
grv = 0.5;
jmp = -10;
ong = false;
knockback_x = 0;
knockback_y = 0;
knockback_strength = 5;

// Status
life_max = 5;
life = 5;
energy_max = 0;
energy = 0;
damage_base = 3;
damage = damage_base;
spd = 2;
spd_max = 10;
attack_speed = 4;
attack_recoil = 2;
attack_knockback = 5;
invencible_time = 80;   // i-frames após levar dano (frames @60) — tempo pra respirar
critical_chance = 0;
lucky_chance = 0;
key = 0;

// Dash
dash_speed = 10;
dash_duration = 8;
dash_cooldown = 30;
dash_timer = 0;
dash_cooldown_timer = 0;
dash_direction = 1;
is_dashing = false;
air_dash_available = true;

// Status Alternable

invencible = false;

// Perks

perks_limit_max = 18;
perks_limit_run = 6;
perks_obtained_run = [];
perks_obtained_run_obj = [];

perk_activatable = noone;
perk_activatable_obj = noone;
perk_activatable_active = noone;

// Moves Attacks

timer_attack = 15;

// Merchant Status

money = 0;


// Additions Variables

move_input = 0;

face = 1;
turn_target_dir = 1;
turning = false;
turn_timer = 0;
turn_duration = 0;
pending_face = 1;

run = false;
tap_timer_left = 0;
tap_timer_right = 0;
double_tap_threshold = 15;

previous_state = state;
smoke_instance = noone;

talking = false;
introduction_start = false;

// Door transition (walk to door center -> spr_player_transition -> room change)
transition_phase = 0; // 0 = andando até o centro da porta, 1 = tocando spr_player_transition
transition_target_x = 0;
transition_destiny = noone;
transition_destiny_slot = noone;
transition_entry_dir = noone; // "up"/"down"/"left"/"right": porta pela qual entra na sala nova
transition_px = 0;
transition_py = 0;
transition_is_boss_door = false;
transition_room_started = false;

swimming = false;
swimming_threshold = 30;
swimming_timer = swimming_threshold;

attacked = false;

air_time = 0;

//depth = 0;

// Sounds Frames Step

footstep_frames_walk = [5, 0];
footstep_frames_run  = [3, 7];
last_foot_frame = -1;

// Config Sound Orientation

// Initial Status

life_max_initial = life_max;
damage_base_initial = damage_base;
damage_initial = damage;
spd_initial = spd;
spd_max_initial = spd_max;
attack_speed_initial = attack_speed;
attack_recoil_initial = attack_recoil;
attack_knockback_initial = attack_knockback;
invencible_time_initial = invencible_time;
critical_chance_initial = critical_chance;
lucky_chance_initial = lucky_chance;
perks_limit_run_initial = perks_limit_run;
perks_obtained_run_initial = [];
perks_obtained_run_obj_initial = [];
key_initial = key;
energy_max_initial = energy_max;
energy_initial = energy;

// Jump Buffer
jump_buffer_timer = 0;
jump_buffer_max   = 8;   // 6~10 frames é ideal

// Coyote Time
coyote_timer      = 0;
coyote_max        = 8;   // 6~10 frames também

// Controle interno
jump_pressed = false;

text_perk = "Perks";
text_status = "Status";

// Status menu open/close animation
status_anim_t = 0;
status_menu_surface = -1;
status_menu_surface_w = 0;
status_menu_surface_h = 0;

// =====================================================================
// Squash & Stretch (juice) — escala dinâmica aplicada por cima do sprite
// =====================================================================
base_scale     = 1.15;   // escala "de repouso" do sprite (era o 1.15 fixo)
sns_x          = 1;      // multiplicador horizontal atual (converge p/ 1)
sns_y          = 1;      // multiplicador vertical atual (converge p/ 1)
sns_xspd       = 0;      // velocidade da mola no eixo X
sns_yspd       = 0;      // velocidade da mola no eixo Y
sns_stiffness  = 0.35;   // rigidez da mola: maior = volta mais rápido
sns_damping    = 0.60;   // amortecimento (0-1): maior = oscila menos
sns_breath_t   = 0;      // fase da "respiração" no idle

// =====================================================================
// Queda / gravidade com mais peso
// =====================================================================
grv_rise      = grv;     // gravidade na subida (mantém o pulo atual)
fall_grv_mult = 1.35;    // cai mais pesado do que sobe (gravidade assimétrica)
fast_fall_mult = 1.7;    // segurar "baixo" no ar acelera a queda
vsp_max_fall  = 15;      // velocidade terminal de queda
hard_land_vsp = 12;      // a partir daqui a aterrissagem "treme a tela"

// =====================================================================
// Ataque com mais fluidez (avanço/lunge no golpe)
// =====================================================================
attack_lunge       = 4.5; // impulso pra frente no frame do golpe
attack_lunge_timer = 0;   // frames restantes de deslize do golpe
attack_lunged      = false;
attack_is_air      = false; // golpe iniciado no ar (recuperação diferente)
attack_hitbox_spawned = false; // garante 1 hitbox por golpe (só reseta em novo ataque)

// =====================================================================
// Feedback ao levar dano
// =====================================================================
hit_flash     = 0;   // frames restantes de flash branco
hit_flash_max = 8;

// =====================================================================
// "Focus" ao levar dano (estilo Hollow Knight): vinheta circular que
// fecha/escurece a tela, câmera travada por um instante e um empurrão
// do obj_player em direção a um dos cantos da tela.
// =====================================================================
hurt_fx_timer    = 0;    // frames restantes do efeito de vinheta
hurt_fx_duration = 42;   // duração total do "focus" (frames @60)
hurt_fx_alpha    = 0.80; // opacidade máxima da vinheta no pico
hurt_fx_close    = 0.26; // fração da diagonal que sobra "limpa" no centro no pico (menor = fecha mais)

hurt_knock_h     = 6;    // impulso horizontal do recuo (pra trás, em direção ao canto)
hurt_knock_v     = 5;    // impulso vertical do recuo (pra cima, em direção ao canto)

// recuo: por alguns frames o horizontal ignora input e a troca de sprite
// fica congelada, pra não "piscar" pulo/queda ao levar o hit.
// O impulso é aplicado em hsp/vsp e resolvido por _resolve_collisions(),
// então NUNCA atravessa obj_wall.
hurt_recoil_timer = 0;
hurt_recoil_max   = 10;

// Ao levar hit NO AR a gravidade volta SUAVE: começa perto de 0 no instante do
// golpe e sobe de volta até 100% ao longo desta janela, em vez de despencar de
// uma vez logo no começo.
hurt_grav_timer = 0;
hurt_grav_max   = 18;   // frames até a gravidade voltar aos 100% (maior = mais "flutuante")

// anti-flicker: atraso pra virar IDLE ao parar de andar
idle_delay = 0;