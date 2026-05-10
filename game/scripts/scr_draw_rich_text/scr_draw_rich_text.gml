function scr_draw_rich_text(_x, _y, _text, _scale, _alpha)
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);

    var current_x = _x;

    var i = 1;

    while (i <= string_length(_text))
    {
        var ch = string_char_at(_text, i);

        // =====================================
        // TAG
        // =====================================

        if (ch == "[")
        {
            var end_pos = string_pos("]", string_delete(_text, 1, i - 1));

            if (end_pos > 0)
            {
                end_pos += i - 1;

                var tag = string_copy(_text, i + 1, end_pos - i - 1);

                var spr = noone;

                switch (tag)
                {
                    case "JUMP_BUTTON":
                        spr = spr_btn_up;
                    break;

                    case "MOVE_BUTTON":
                        spr = spr_btn_move;
                    break;

                    case "KEY_E":
                        spr = spr_key_e;
                    break;

                    case "KEY_F":
                        spr = spr_key_f;
                    break;
                }

                // =====================================
                // DESENHA ÍCONE
                // =====================================

                if (spr != noone)
                {
                    var icon_scale = _scale * 2;

                    var icon_w = sprite_get_width(spr) * icon_scale;
                    var icon_h = sprite_get_height(spr) * icon_scale;

                    var visual_padding = _scale;

                    var total_icon_w = icon_w + (visual_padding * 2);

                    // draw_sprite_ext usa centro
                    var draw_x = current_x + visual_padding + (icon_w * 0.5);

                    draw_sprite_ext(
                        spr,
                        0,
                        draw_x,
                        _y,
                        icon_scale,
                        icon_scale,
                        0,
                        c_white,
                        _alpha
                    );

                    // avança corretamente
                    current_x += total_icon_w;

                    i = end_pos + 1;

                    continue;
                }
            }
        }

        // =====================================
        // TEXTO NORMAL
        // =====================================

        draw_text_transformed(
            current_x,
            _y,
            ch,
            _scale,
            _scale,
            0
        );

        current_x += string_width(ch) * _scale;

        i++;
    }
}

function scr_rich_text_width(_text, _scale)
{
    var total_w = 0;

    var i = 1;

    while (i <= string_length(_text))
    {
        var ch = string_char_at(_text, i);

        // =====================================
        // TAG
        // =====================================

        if (ch == "[")
        {
            var end_pos = string_pos("]", string_delete(_text, 1, i - 1));

            if (end_pos > 0)
            {
                end_pos += i - 1;

                var tag = string_copy(_text, i + 1, end_pos - i - 1);

                var spr = noone;

                switch (tag)
                {
                    case "JUMP_BUTTON":
                        spr = spr_btn_up;
                    break;

                    case "MOVE_BUTTON":
                        spr = spr_btn_move;
                    break;

                    case "KEY_E":
                        spr = spr_key_e;
                    break;

                    case "KEY_F":
                        spr = spr_key_f;
                    break;
                }

                // =====================================
                // WIDTH DO ÍCONE
                // =====================================

                if (spr != noone)
                {
                    var icon_scale = _scale * 2;

                    var icon_w = sprite_get_width(spr) * icon_scale;

                    var visual_padding = _scale;

                    total_w += icon_w + (visual_padding * 2);

                    i = end_pos + 1;

                    continue;
                }
            }
        }

        // =====================================
        // TEXTO NORMAL
        // =====================================

        total_w += string_width(ch) * _scale;

        i++;
    }

    return total_w;
}