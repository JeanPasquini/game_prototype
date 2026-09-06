function scr_draw_rich_text(_x, _y, _text, _scale, _alpha, _align = noone)
{
    draw_set_valign(fa_middle);
    draw_set_halign(fa_left); // sempre desenha internamente como left

    // --- PASSO 1: calcular a largura total da linha (até o primeiro \n) ---
    var total_width = 0;
    var i = 1;
    while (i <= string_length(_text))
    {
        var ch = string_char_at(_text, i);

        if (ch == "\\" && i < string_length(_text))
        {
            var next_ch = string_char_at(_text, i + 1);
            if (next_ch == "n") break; // só mede até a quebra de linha
        }

        if (ch == "[")
        {
            var end_pos = string_pos("]", string_delete(_text, 1, i - 1));
            if (end_pos > 0)
            {
                end_pos += i - 1;
                var tag = string_copy(_text, i + 1, end_pos - i - 1);
                var spr = scr_prompt_sprite(tag);
                if (spr != noone)
                {
                    var icon_scale = _scale * 2;
                    var icon_w = sprite_get_width(spr) * icon_scale;
                    var visual_padding = _scale;
                    total_width += icon_w + (visual_padding * 2);
                    i = end_pos + 1;
                    continue;
                }
            }
        }
        total_width += string_width(ch) * _scale;
        i++;
    }

    // --- PASSO 2: calcular o x inicial baseado no align ---
    var start_x = _x;
    if (_align == "center")
    {
        start_x = _x - (total_width * 0.5);
    }
    else if (_align == "right")
    {
        start_x = _x - total_width;
    }

    // --- PASSO 3: desenhar normalmente, sempre com fa_left, a partir de start_x ---
    var current_x = start_x;
    i = 1;
    while (i <= string_length(_text))
    {
        var ch = string_char_at(_text, i);

        if (ch == "\\" && i < string_length(_text))
        {
            var next_ch = string_char_at(_text, i + 1);
            if (next_ch == "n")
            {
                current_x = start_x; // volta pro início alinhado, não pro _x original
                _y += string_height("A") * _scale * 1.5;
                i += 2;
                continue;
            }
        }
        if (ch == "[")
        {
            var end_pos = string_pos("]", string_delete(_text, 1, i - 1));
            if (end_pos > 0)
            {
                end_pos += i - 1;
                var tag = string_copy(_text, i + 1, end_pos - i - 1);
                var spr = scr_prompt_sprite(tag);
                if (spr != noone)
                {
                    var icon_scale = _scale * 2;
                    var icon_w = sprite_get_width(spr) * icon_scale;
                    var icon_h = sprite_get_height(spr) * icon_scale;
                    var visual_padding = _scale;
                    var total_icon_w = icon_w + (visual_padding * 2);
                    var draw_x = current_x + visual_padding + (icon_w * 0.5);
                    draw_sprite_ext(
                        spr, 0, draw_x, _y,
                        icon_scale, icon_scale, 0, c_white, _alpha
                    );
                    current_x += total_icon_w;
                    i = end_pos + 1;
                    continue;
                }
            }
        }
        draw_text_transformed(current_x, _y, ch, _scale, _scale, 0);
        current_x += string_width(ch) * _scale;
        i++;
    }
}

function scr_rich_text_width(_text, _scale)
{
    var current_w = 0;
    var max_w = 0;

    var i = 1;

    while (i <= string_length(_text))
    {
        var ch = string_char_at(_text, i);

        if (ch == "\\" && i < string_length(_text))
        {
            var next_ch = string_char_at(_text, i + 1);

            if (next_ch == "n")
            {
                max_w = max(max_w, current_w);

                current_w = 0;

                i += 2;

                continue;
            }
        }

        if (ch == "[")
        {
            var end_pos = string_pos("]", string_delete(_text, 1, i - 1));

            if (end_pos > 0)
            {
                end_pos += i - 1;

                var tag = string_copy(_text, i + 1, end_pos - i - 1);

                var spr = scr_prompt_sprite(tag);

                if (spr != noone)
                {
                    var icon_scale = _scale * 2;

                    var icon_w = sprite_get_width(spr) * icon_scale;

                    var visual_padding = _scale;

                    current_w += icon_w + (visual_padding * 2);

                    i = end_pos + 1;

                    continue;
                }
            }
        }

        current_w += string_width(ch) * _scale;

        i++;
    }

    max_w = max(max_w, current_w);

    return max_w;
}