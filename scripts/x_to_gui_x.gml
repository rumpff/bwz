/// x_to_gui_x(x)
/// turns an x position to the same position on the screen but on the gui

var _x = argument0;
var _xview = view_xview;
var _wview = view_wview;
var _wgui = display_get_gui_width();

var output;
var difference = (_wgui / _wview);

output = (_x - _xview) * difference;

return output;
