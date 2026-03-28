is_destroyed = false
created = false;

tentacles = ds_list_create();
max_tentacles = 6;
count_destroyed_tentacles = 0;
min_tentacles_to_destroy = 4;
last_count_tentacles = 0;

telegraph_timer_base = 180;
telegraph_timer = telegraph_timer_base;
telegraphX = 0;
telegraphY = 0;

