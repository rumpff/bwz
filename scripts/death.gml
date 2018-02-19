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
with(argument0) { instance_destroy(); }
