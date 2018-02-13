/// shoot_arrow(x, y, angle, playerId)

arrow = instance_create(argument0, argument1, obj_arrow);
arrow.m_angle = argument2; 
arrow.m_id = argument3
with (arrow) 
{ event_user(0); }

return arrow;
