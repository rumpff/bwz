///death(player, killerIdId, arrow)
// Kills the player, enter -1 if not killed by a player
// Enter -1 by arrow if not killed by arrow

var player = argument0;
var killerId = argument1;
var arrow = argument2;

split_sprite_1 = noone;
split_sprite_2 = noone;

ds_sprites = ds_list_create();
obj_gameManager.m_recentKillPos[0] = player.x;
obj_gameManager.m_recentKillPos[1] = player.y;


global.deaths[player.m_playerId]++;
screenshake(100); // Add some screenshake

if(killerId != player.m_playerId && killerId != -1)
{
    var scoreAmount = 1;
    var abilityAmount = 10;
    if(obj_gameManager.m_playerKillStreak[player.m_playerId] > BOUNTY_THRESHOLD) 
    { scoreAmount = 2; abilityAmount = 20;}
    
    global.playerScore[killerId] += scoreAmount;
    obj_gameManager.m_playerKillStreak[killerId]++;
    if(!obj_gameManager.m_playerAbilityActive[killerId])
    { global.playerAbility[killerId] += abilityAmount; }
    global.playersKilled[killerId, player.m_playerId]++;
    
    with(instance_create(x, y, obj_scoreEffect))
    {
       m_playerId = argument1
       event_user(0);
    }
}
else if(killerId == player.m_playerId)
{
    play_sound(snd_laughing);
    global.selfKills[killerId]++;
}
obj_gameManager.m_playerDeathTimers[player.m_playerId] = global.deathCooldown;
obj_gameManager.m_playerKillStreak[player.m_playerId] = 0;

gamepad_rumble(argument0.m_playerId, 1, 10);

var parAmount = 100;

if(arrow != -1)
{
    // Spawn player splices
    var x1 = arrow.x;
    var y1 = arrow.y;
    
    var x2 = arrow.x + arrow.m_moveX;
    var y2 = arrow.y + arrow.m_moveY;
    
    var angle = point_direction(x1, y1, x2, y2);
    var sped = random_range(5, 15);
    
    for (i = 0; i < 2; i++)
    {
        var p = instance_create(player.x, player.y, obj_playerPart);

        p.m_angle = angle;
        p.m_id = player.m_playerId;
        p.m_spriteId = i;
        p.sped = sped;
            
        with(p) { event_user(0); }
    }
    
    // Spawn blood with arrow's angle
    repeat(parAmount)
    {   
        var bld = instance_create(player.x, player.y, obj_blood); 
        bld.m_arrowAngle = angle;
        
        with(bld) { event_user(0); }
    }
}
else
{
    // Spawn blood without
    repeat(parAmount)
    {   
        var bld = instance_create(player.x, player.y, obj_blood);
        bld.m_arrowAngle = 11037;
        
        with(bld) { event_user(0); }
    }
}
instance_destroy(player);
play_sound(snd_playerDeath1);

if(!global.firstBlood)
{
    global.firstBlood = true;
    effec = instance_create(0, 0, obj_firstBlood);
    effec.player = killerId;
    with(effec) { event_user(0); }
}

obj_gameManager.m_deathSlowdown = 0;
