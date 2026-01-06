/// @func scr_draw_text_wrap_scaled(_text, _x, _y, _max_width, _scale, _font)
/// @desc Desenha texto com quebra automática de linha e escala
///
/// @param _text       string
/// @param _x          x inicial
/// @param _y          y inicial
/// @param _max_width  largura máxima (sem scale aplicado)
/// @param _scale      escala do texto
/// @param _font       fonte usada

function scr_draw_text_wrap_scaled(_text, _x, _y, _max_width, _scale, _font)
{
    draw_set_font(_font);

    var words = string_split(_text, " ");
    var lines = [];
    var line = "";

    for (var i = 0; i < array_length(words); i++)
    {
        var test_line = line;
        if (line != "") test_line += " ";
        test_line += words[i];

        if (string_width(test_line) > _max_width)
        {
            array_push(lines, line);
            line = words[i];
        }
        else
        {
            line = test_line;
        }
    }

    if (line != "")
        array_push(lines, line);

    var line_height = (font_get_size(_font) + 2) * _scale;

    for (var i = 0; i < array_length(lines); i++)
    {
        draw_text_transformed(
            _x,
            _y + (i * line_height),
            lines[i],
            _scale, _scale, 0
        );
    }
}
