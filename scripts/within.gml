/// within(val, min, max)
var val = argument0;
var a = argument1;
var b = argument2;

var left = min(a,b);
var right = max(a,b);

return (left < val && val < right)
