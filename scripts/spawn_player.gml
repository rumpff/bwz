///spawn_player(objArray, playerNumb)
objArray = argument0;
playerNumb = argument1;

var Id;
Id = random_range(0, array_length_1d(objArray));

player = instance_create(objArray[Id].x, objArray[Id].y, obj_player);
player.m_playerId = playerNumb; 
with (player) 
{ event_user(0); }

var spwnEffect = instance_create(player.x, player.y, obj_spawnEffect);
spwnEffect.m_id = argument1;
with(spwnEffect) { event_user(0); }
screenshake(64);

return player;
