///screenshake(amount)

if(instance_exists(obj_camera))
{
    obj_camera.m_shakeMagnitude += argument0;
}
