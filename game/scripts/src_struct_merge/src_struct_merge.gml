function src_struct_merge(a, b)
{
    var result = {};

    if (is_struct(a)) {
        var keys = variable_struct_get_names(a);
        for (var i = 0; i < array_length(keys); i++) {
            var key = keys[i];
            result[$ key] = a[$ key];
        }
    }

    if (is_struct(b)) {
        var keys = variable_struct_get_names(b);
        for (var i = 0; i < array_length(keys); i++) {
            var key = keys[i];
            result[$ key] = b[$ key];
        }
    }

    return result;
}
