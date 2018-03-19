///death(player, killerIdId)
// Kills the player, enter -1 if not killed by a player

var player = argument0;
var killerId = argument1;

screenshake(100); // Add some screenshake
obj_gameManager.m_playerDeathTimers[player.m_playerId] = global.deathCooldown;

if(killerId != player.m_playerId && killerId != -1)
{
    obj_gameManager.m_playerScore[killerId] += 1;
}

var parAmount = 50;

repeat(parAmount)
{ instance_create(player.x, player.y, obj_blood); }

instance_destroy(player);
instance_create(x, y, obj_scoreEffect);
audio_play_sound(snd_playerDeath1, 1 ,0);
