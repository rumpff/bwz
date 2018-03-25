///death(player, killerIdId, arrow)
// Kills the player, enter -1 if not killed by a player
// Enter -1 by arrow if not killed by arrow

var player = argument0;
var killerId = argument1;
var arrow = argument2;

split_sprite_1 = noone;
split_sprite_2 = noone;

ds_sprites = ds_list_create();

screenshake(100); // Add some screenshake
obj_gameManager.m_playerDeathTimers[player.m_playerId] = global.deathCooldown;


if(killerId != player.m_playerId && killerId != -1)
{
    obj_gameManager.m_playerScore[killerId] += 1;
    
    with(instance_create(x, y, obj_scoreEffect))
    {
       m_playerId = argument1
    }
}

gamepad_rumble(argument0.m_playerId, 1, 20);

var parAmount = 100;

repeat(parAmount)
{ var bld = instance_create(player.x, player.y, obj_blood); }

if(arrow != -1)
{
    var headSpr = head_sprite(global.playerHead[player.m_playerId])

    var x1 = arrow.x;
    var y1 = arrow.y;
    
    var x2 = arrow.x + arrow.m_moveX;
    var y2 = arrow.y + arrow.m_moveY;
    
    for (i = 0; i < 2; i++)
    {
        var p = instance_create(player.x, player.y, obj_playerPart);
        
        p.m_x0 = player.x;
        p.m_y0 = player.y;
        
        p.m_x1 = x1;
        p.m_y1 = y1;
        
        p.m_x2 = x2;
        p.m_y2 = y2;
        
        p.m_id = i;
        p.m_sprite = headSpr
        
        with(p) { event_user(0); }
    }

}

instance_destroy(player);
play_sound(snd_playerDeath1);
