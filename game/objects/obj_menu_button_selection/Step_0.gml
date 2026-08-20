var manager_obj = asset_get_index(manager_object_name);
var manager = (manager_obj != -1) ? instance_find(manager_obj, 0) : noone;

if (manager != noone && manager.button_id == my_id)
{
	image_alpha = 1;
}
else
{
	image_alpha = 0;
}
