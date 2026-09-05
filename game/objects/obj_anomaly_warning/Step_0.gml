switch (state) {

    case "wait":
        // espera a cutscene de transicao / vinheta de entrada terminar
        if (!scr_menu_lock_blocks_world()) {
            state = "in";
            t = 0;
        }
        break;

    case "in":
        t += 1;
        a = clamp(t / fade_in, 0, 1);
        yoff = lerp(-24, 0, a);
        if (t >= fade_in) { a = 1; yoff = 0; state = "hold"; t = 0; }
        break;

    case "hold":
        t += 1;
        if (t >= hold) { state = "out"; t = 0; }
        break;

    case "out":
        t += 1;
        a = clamp(1 - (t / fade_out), 0, 1);
        yoff = lerp(0, -18, t / fade_out);
        if (t >= fade_out) instance_destroy();
        break;
}
