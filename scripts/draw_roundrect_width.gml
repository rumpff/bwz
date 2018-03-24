///draw_roundrect_width(x1, y2, x2, y2, width);

var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var width = argument4;

for (d = 0; d < width; d++)
{
    for (i = 0; i < 16; i++)
    {
        var dist = d + 1;
        
        var xOff = lengthdir_x(dist, i*(45/2));
        var yOff = lengthdir_y(dist, i*(45/2));
        
        draw_roundrect(x1 + xOff, y1 + yOff, x2 + xOff, y2 + yOff, true);
    }
}

//draw_roundrect(x1, y1, x2, y2, true);
