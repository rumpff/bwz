///gamepad_rumble(id, startAmount, time)

with(instance_create(0, 0, obj_rumble))
{
    m_id = argument0;
    m_rumbleStart = argument1;
    m_maxTime = argument2;
}
