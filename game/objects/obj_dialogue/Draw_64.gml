if (array_length(dialogue_lines) > 0) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    var bar_height = 40;

    // desenhar a barra preta
    draw_set_color(c_black);
    draw_rectangle(0, gui_h - bar_height, gui_w, gui_h, false);

    // desenhar o texto
    draw_set_color(c_white);
    draw_text(gui_w / 2, gui_h - bar_height + 10, dialogue_lines[current_line] + " [" + string(current_line) + "]");
}
