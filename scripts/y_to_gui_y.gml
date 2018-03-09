/// y_to_gui_y(y)
/// turns an y position to the same position on the screen but on the gui

var _y = argument0;
var _yview = view_yview;
var _hview = view_hview;
var _hgui = display_get_gui_height();

var output;
var difference = (_hgui / _hview);

output = (_y - _yview) * difference;

return output;
