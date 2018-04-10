/// draw_triangle_width(x1, y1, x2, y2, x3, y3, width)

var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var x3 = argument4;
var y3 = argument5;
var width = argument6;

draw_line_width(x1, y1, x2, y2, width);
draw_line_width(x2, y2, x3, y3, width);
draw_line_width(x3, y3, x1, y1, width);
