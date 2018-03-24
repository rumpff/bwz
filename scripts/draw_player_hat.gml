///draw_player_hat(xOff, yOff, col)

var xOff = argument0;
var yOff = argument1;
var col = argument2;

var ypos;

if(m_vsp > 0) { ypos = yprevious; }
else { ypos = y; }

var xdir = m_imageDirection;

// Calculate the vertical offset
m_hatBX = x + lengthdir_x(m_hatHeight - m_bodyOffsetY, m_bodyAngle + 90);
m_hatBY = ypos + lengthdir_y(m_hatHeight - m_bodyOffsetY, m_bodyAngle + 90);

// Add the horizontal offset
var val = 0;
if(xdir == 1) { val = 180; }

m_hatX = m_hatBX + lengthdir_x(8, m_bodyAngle - val);
m_hatY = m_hatBY + lengthdir_y(8, m_bodyAngle - val);

draw_sprite_ext(m_spriteHat, 0, m_hatX + xOff, m_hatY + yOff,
xdir, 1, (12 * xdir) + m_bodyAngle, col, 1);
