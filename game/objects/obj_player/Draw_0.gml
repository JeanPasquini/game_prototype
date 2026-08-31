var _scale = base_scale;

// A MÁSCARA DE COLISÃO é fixa (definida no Create: mask_index = spr_player_idle,
// image_xscale = 1, image_yscale = 1.15 constantes). Tudo daqui pra baixo — flip
// pelo "face", squash & stretch, foot_lift — é 100% VISUAL, só no draw_sprite_ext.

// Estados onde o squash & stretch NÃO deve aparecer:
// morte (ar/chão), indo pra porta / transição de room, carregando a próxima
// room, e introdução (jogo e boss). Nesses casos zera a mola pra render limpo
// e pra não "estourar" ao voltar ao normal.
var _no_squash =
       state == PlayerState.DYING
    || state == PlayerState.TRANSITION
    || state == PlayerState.INTRODUCTION
    || instance_exists(obj_transiction)
    || (instance_exists(obj_menu_boss_introduction) && obj_menu_boss_introduction.boss_introduction);

if (_no_squash) {
    sns_x = 1; sns_y = 1;
    sns_xspd = 0; sns_yspd = 0;
    sns_breath_t = 0;
}

// escala VISUAL (base + mola de squash & stretch)
var _vis_sx = face * _scale * sns_x;
var _vis_sy = _scale * sns_y;

// compensa a origem do sprite pra os "pés" ficarem plantados durante o squash;
// foot_lift levanta o desenho alguns px pra não afundar no chão
var _below  = (sprite_get_height(sprite_index) * _scale) - sprite_get_yoffset(sprite_index);
var _draw_y = y - _below * (_vis_sy - _scale) - foot_lift;

// desenha o sprite + overlay branco quando levou dano (hit flash)
var _draw_player = function(_dy, _sx, _sy) {
    draw_sprite_ext(sprite_index, image_index, x, _dy, _sx, _sy, image_angle, image_blend, image_alpha);

    if (hit_flash > 0) {
        var _a = (hit_flash / hit_flash_max);
        gpu_set_fog(true, c_white, 0, 0);
        draw_sprite_ext(sprite_index, image_index, x, _dy, _sx, _sy, image_angle, c_white, _a);
        gpu_set_fog(false, c_white, 0, 0);
    }
};

if (global.hitstop > 0) {
    image_speed = 0;
    _draw_player(_draw_y, _vis_sx, _vis_sy);
    exit;
}

if (invencible) {
    if ((irandom_range(0,10)) < 6) {
        _draw_player(_draw_y, _vis_sx, _vis_sy);
    }
} else {
    _draw_player(_draw_y, _vis_sx, _vis_sy);
}


function get_state_name(state_val) {
    switch (state_val) {
        case PlayerState.IDLE:         return "IDLE";
        case PlayerState.WALK:         return "WALK";
        case PlayerState.WALK_TURN:    return "WALK_TURN";
        case PlayerState.RUN:          return "RUN";
        case PlayerState.RUN_TURN:     return "RUN_TURN";
        case PlayerState.JUMP:         return "JUMP";
        case PlayerState.RUN_JUMP:	   return "RUN_JUMP";
        case PlayerState.FALL:         return "FALL";
        case PlayerState.RUN_FALL:     return "RUN_FALL";
        case PlayerState.ATTACK:	   return "ATTACK";
        case PlayerState.TALKING:      return "TALKING";
        case PlayerState.WAIT_ATTACK:  return "WAIT_ATTACK";
        case PlayerState.DYING:        return "DYING";
        case PlayerState.DASH:         return "DASH";
        case PlayerState.INTRODUCTION: return "INTRODUCTION";
        case PlayerState.TRANSITION:   return "TRANSITION";
        default:                       return "UNKNOWN";
    }
}

var texto = get_state_name(state);
var texto_x = obj_player.x;
var texto_y = obj_player.y-50;

draw_set_font(fnt_player_states);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

draw_text_transformed(texto_x, texto_y, texto, 0.5, 0.5, 0);
