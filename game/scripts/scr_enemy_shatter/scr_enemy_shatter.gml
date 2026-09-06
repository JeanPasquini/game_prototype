/// @function scr_enemy_shatter(_inst, [_from_x], [_chunk], [_max_chunks])
/// @description Quebra o inimigo _inst em detritos de pixel (obj_pixel_debris) a partir do
///              frame de sprite ATUAL. Le a cor real de cada bloco do sprite, respeita o
///              flip visual (face_scale) e dispara os detritos com velocidade radial a
///              partir do centro + um empurrao no sentido "pra longe do golpe".
///              Chamado no golpe fatal, em obj_enemy_parent/Step_0.
/// @param {Id.Instance} _inst        inimigo que vai estilhacar
/// @param {Real}        [_from_x]    x da origem do golpe (empurra os detritos pro lado oposto); undefined = ignora
/// @param {Real}        [_chunk]     tamanho do bloco em pixels (2 ou 3). default 3
/// @param {Real}        [_max_chunks] teto de detritos por morte. default 120
function scr_enemy_shatter(_inst, _from_x = undefined, _chunk = 3, _max_chunks = 120) {

    if (!instance_exists(_inst)) return;

    // teto global de seguranca: se a tela ja esta cheia de detrito (ex.: perk que
    // mata varios de uma vez), reduz o orcamento desta morte em vez de somar 100+.
    var _global_count = instance_number(obj_pixel_debris);
    if (_global_count > 1200) _max_chunks = min(_max_chunks, 30);
    else if (_global_count > 700) _max_chunks = min(_max_chunks, 60);

    with (_inst) {

        var _spr = sprite_index;
        if (_spr == -1 || !sprite_exists(_spr)) exit;

        var _sub = floor(image_index) mod max(1, sprite_get_number(_spr));
        var _sw  = sprite_get_width(_spr);
        var _sh  = sprite_get_height(_spr);
        var _xo  = sprite_get_xoffset(_spr);
        var _yo  = sprite_get_yoffset(_spr);

        // --- desenha o frame atual num surface do tamanho do sprite ---
        var _surf = surface_create(_sw, _sh);
        if (!surface_exists(_surf)) exit;

        surface_set_target(_surf);
        draw_clear_alpha(0, 0);
        // bm_one / bm_zero => dest = src, sem blend com o fundo transparente:
        // a cor sai crua, sem "halo" nas bordas nem alpha pre-multiplicado.
        gpu_set_blendmode_ext(bm_one, bm_zero);
        draw_sprite(_spr, _sub, _xo, _yo);
        gpu_set_blendmode(bm_normal);
        surface_reset_target();

        // A cor e lida com surface_getpixel_ext, que ja devolve no formato de cor
        // do GameMaker (0xBBGGRR nos 24 bits baixos) + alpha no byte alto. Assim
        // nao ha palpite de ordem de bytes (buffer_get_surface + BGRA/RGBA e o que
        // fazia o bibipig, rosa/vermelho, sair azulado).

        var _flip    = (face_scale < 0);   // sprite desenhado espelhado na horizontal
        var _spawned = 0;
        var _step    = max(1, _chunk);

        // centro de "explosao": um pouco acima do pe do sprite fica mais natural
        var _cx = x;
        var _cy = y - _yo * 0.5;

        var _py = _step div 2;
        while (_py < _sh && _spawned < _max_chunks) {

            var _px = _step div 2;
            while (_px < _sw && _spawned < _max_chunks) {

                var _c = surface_getpixel_ext(_surf, _px, _py);
                var _a = (_c >> 24) & 0xFF;

                if (_a >= 40) {
                    var _col = _c & 0xFFFFFF;   // ja e uma cor valida do GameMaker

                    // posicao do bloco no mundo. O sprite e desenhado com xscale =
                    // face_scale (ver obj_enemy_parent/Draw), entao quando _flip o
                    // deslocamento em relacao a origem inverte de sinal.
                    var _rel_x = _px - _xo;
                    if (_flip) _rel_x = -_rel_x;
                    var _wx = x + shake_x + _rel_x;
                    var _wy = y + shake_y + (_py - _yo);

                    // "Instances" e a layer padrao usada pelo resto do projeto
                    // (ver obj_enemy_parent/Alarm_3, obj_damage_text).
                    var _d = instance_create_layer(_wx, _wy, "Instances", obj_pixel_debris);
                    _d.chunk_size = _chunk;
                    _d.col = _col;

                    // velocidade radial a partir do centro + pop pra cima
                    var _ang = point_direction(_cx, _cy, _wx, _wy) + random_range(-20, 20);
                    var _spd = random_range(1.0, 3.4);
                    _d.hsp = lengthdir_x(_spd, _ang);
                    _d.vsp = lengthdir_y(_spd, _ang) - random_range(1.2, 2.8);

                    // empurrao pro lado oposto ao golpe
                    if (_from_x != undefined) {
                        var _away = (x >= _from_x) ? 1 : -1;
                        _d.hsp += _away * random_range(0.8, 2.2);
                    }

                    _spawned++;
                }

                _px += _step;
            }

            _py += _step;
        }

        surface_free(_surf);
    }
}
