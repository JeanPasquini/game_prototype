if (delay_frames > 0) {
    delay_frames--;
    exit;
}

if (image_alpha < 1) {
    image_alpha = min(image_alpha + fade_speed, 1);
    image_xscale = min(image_xscale + scale_speed, scale_target);
    image_yscale = min(image_yscale + scale_speed, scale_target);
}
