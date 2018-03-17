///draw_roundrect_width(x1, y2, x2, y2, width);

var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var width = argument4;


for (i = width/2-(width/2); i < width/2; i++)
{
    draw_roundrect(x1 - i, y1, x2, y2, true);
    draw_roundrect(x1, y1 - i, x2, y2, true);
    draw_roundrect(x1, y1, x2 + i, y2, true);
    draw_roundrect(x1, y1, x2, y2 + i, true);
}
