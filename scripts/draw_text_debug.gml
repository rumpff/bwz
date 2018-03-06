///draw_text_debug(numb, string)
// Draws text with transparent box below it so that it's always readable

draw_set_font(fnt_debug);

// Obtain some values
stringWidth = string_width(argument1)
stringHeight = string_height(argument1)

// Draw the box
draw_set_color(c_black);
draw_set_alpha(0.4);
draw_rectangle(4, 4 + argument0 * stringHeight, 4 + stringWidth, 
               4 + (argument0 * stringHeight - 1) + stringHeight, false);

// Draw the text
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_left);

draw_text(4, 4 + argument0 * stringHeight, argument1);
