image_xscale = 1.15;
image_yscale = 1.15;

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
damage_base = 1;
damage = damage_base;
spd = 2;
spd_max = 10;
attack_speed = 4;
attack_recoil = 2;
attack_knockback = 5;
invencible_time = 50;
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

// anti-flicker: atraso pra virar IDLE ao parar de andar
idle_delay = 0;