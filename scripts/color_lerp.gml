/// color_lerp(color A, color B, amount T)
// Ported from: https://www.alanzucconi.com/2016/01/06/colour-interpolation/2/
// Hue interpolation

var outputColor = c_fuchsia;

var colorA = argument0;
var colorB = argument1;
var t = argument2;

var h = 0;
var d = colour_get_hue(colorB) - colour_get_hue(colorA);

/*
if (colour_get_hue(colorA) > colour_get_hue(colorB))
{
    // Swap (a's hue, b's hue)
    var h3 = colour_get_hue(colorB);
    colorB = color_change_hue(colorB, color_get_hue(colorA));
    colorA = color_change_hue(colorA, h3);
    
    d = -d;
    t = 1 - t;
}
*/

if (d > 127.5) // 180deg
{
    colorA = color_change_hue(colorA, colour_get_hue(colorA) + 255); // 360deg
    h = (colour_get_hue(colorA) + t * (colour_get_hue(colorB) - colour_get_hue(colorA))) % 255; // 360deg
}

if (d <= 127.5) // 180deg
{
    h = colour_get_hue(colorA) + t * d
}

// Interpolate the rest
outputColor = make_colour_hsv(h, // H
    colour_get_saturation(colorA) + t * (colour_get_saturation(colorB) - colour_get_saturation(colorA)), // S
    colour_get_value(colorA) + t * (colour_get_value(colorB) - colour_get_value(colorA))); // V

return outputColor;
