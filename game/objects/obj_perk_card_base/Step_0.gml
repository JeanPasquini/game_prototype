if (selected)
{
    select_time += 1;
}
else
{
    select_time = 0;
}


if (confirm_select)
{
    on_selected();
    confirm_select = false;
}

function on_selected()
{
    
}
