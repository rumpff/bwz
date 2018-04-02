/// shoot_arrow(x, y, angle, force, playerId)

var angle = argument2;
var force = argument3;
var pId = argument4;
var type = 0;
var xspwn, yspwn;

if(obj_gameManager.m_playerAbilityActive[pId] == true)
{ type = global.playerBow[pId]+1;}

xspwn = argument0 - lengthdir_x(ARROW_LENGTH/2, angle);
yspwn = argument1 - lengthdir_y(ARROW_LENGTH/2, angle);

if(type == 1)
{
    arrow = instance_create(xspwn, yspwn, obj_arrow);
    arrow.m_angle = angle - 5;
    arrow.m_force = force;
    arrow.m_id = pId;
    arrow.m_arrowType = type;
    with (arrow) 
    { event_user(0); }
    
    arrow = instance_create(xspwn, yspwn, obj_arrow);
    arrow.m_angle = angle + 5;
    arrow.m_force = force;
    arrow.m_id = pId;
    arrow.m_arrowType = type;
    with (arrow) 
    { event_user(0); }
    
}

arrow = instance_create(xspwn, yspwn, obj_arrow);
arrow.m_angle = angle;
arrow.m_force = force;
arrow.m_id = pId;
arrow.m_arrowType = type;
with (arrow) 
{ event_user(0); }

var sound = choose(snd_arrowShoot1, snd_arrowShoot2, snd_arrowShoot3, snd_arrowShoot4);
if(type != 0) { sound = snd_arrowShootAbility }
play_sound(sound);

return arrow;
