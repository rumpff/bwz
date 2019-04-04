/// color_change_hue(color, hue)

var color = argument0;
var hue = argument1;

return make_colour_hsv(hue, colour_get_saturation(color), color_get_value(color));
