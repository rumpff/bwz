///spawn_player(objArray, playerNumb)
objArray = argument0;
playerNumb = argument1;

var randomId = random_range(0, instance_number(obj_spawnLocation))

player = instance_create(objArray[randomId].x, objArray[randomId].y, obj_player);
player.m_playerId = playerNumb; 
with (player) 
{ event_user(0); }

var spwnEffect = instance_create(player.x, player.y, obj_spawnEffect);
spwnEffect.m_id = argument1;
with(spwnEffect) { event_user(0); }

return player;
