if (warning_active) {
    warn_pulse += 0.25;
    warn_timer--;
    if (warn_timer <= 0) do_spawn();
}
