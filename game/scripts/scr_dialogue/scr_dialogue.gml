function scr_load_dialogue(_id, _progress, _dialogue) {
    var dialogue_lines = [];
    var file = _dialogue;

    if (file_exists(file)) {
        var f = file_text_open_read(file);
        if (!file_text_eof(f)) file_text_readln(f);

        while (!file_text_eof(f)) {
            var line = file_text_read_string(f);
            file_text_readln(f);

            if (string_length(line) > 0) {
                var parts = string_split(line, ",");
                if (array_length(parts) >= 3) {
                    var line_id = real(parts[0]);
                    var prog = real(parts[1]);
                    var texto = string_trim(parts[2]);

                    if (_id != -1) {
                        if (line_id == _id) {
                            array_push(dialogue_lines, texto);
                        }
                    } else {
                        if (prog == _progress) {
                            array_push(dialogue_lines, texto);
                        }
                    }
                }
            }
        }
        file_text_close(f);
    }

    return dialogue_lines;
}
