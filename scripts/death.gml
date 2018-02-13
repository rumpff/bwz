///death(player, killerId)
// Kills the player, enter -1 if not killed by a player
screenshake(100);
var killer = argument1;
obj_gameManager.m_playerDeathTimers[argument0.m_playerId] = global.deathCooldown;
with(argument0) { instance_destroy(); }
