///draw_parralellogram(x1, y1, x2, y2, x3, y3, x4, y4, outline)

/***************************************************
  Draws a parralellogram,
  coördinates go from left to right, up to down.
  However, rotating those shouldn't be a problem
 ***************************************************/

// Put parameters in variables
var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var x3 = argument4;
var y3 = argument5;
var x4 = argument6;
var y4 = argument7;
var outline = argument8;

if(outline) // Draw only four lines
{
    draw_line(x1, y1, x2, y2);
    draw_line(x1, y1, x3, y3);
    draw_line(x2, y2, x4, y4);
    draw_line(x3, y3, x4, y4);
}
else // Draw 2 triangles to make a parralellogram
{
    draw_triangle(x1, y1, x2, y2, x3, y3, false);
    draw_triangle(x2, y2, x3, y3, x4, y4, false);
}
