/// shoot_arrow(x, y, angle, force, playerId, arrowType)

var angle = argument2;
var force = argument3;
var pId = argument4;
var type = 0;
var xspwn, yspwn;

if(obj_gameManager.m_playerAbilityActive[pId] == true)
{ type = global.playerBow[pId]+1;}

xspwn = argument0 - lengthdir_x(ARROW_LENGTH/2, angle);
yspwn = argument1 - lengthdir_y(ARROW_LENGTH/2, angle);

arrow = instance_create(xspwn, yspwn, obj_arrow);
arrow.m_angle = angle;
arrow.m_force = force;
arrow.m_id = pId;
arrow.m_arrowType = type;
with (arrow) 
{ event_user(0); }

return arrow;
