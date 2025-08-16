y += y_speed;
alpha -= 1/30;
frame -= 1;
if (frame <= 0) {
    instance_destroy();
}
