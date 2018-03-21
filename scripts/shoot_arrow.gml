/// shoot_arrow(x, y, angle, force, playerId, arrowType)

arrow = instance_create(argument0, argument1, obj_arrow);
arrow.m_angle = argument2;
arrow.m_force = argument3;
arrow.m_id = argument4;
arrow.m_arrowType = argument5;
with (arrow) 
{ event_user(0); }

return arrow;
