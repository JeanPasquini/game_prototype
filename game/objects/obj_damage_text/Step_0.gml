y += y_speed;
alpha -= 1/frame;
frame -= 1;
if (frame <= 0) {
    instance_destroy();
}
