///play_sound(index)

var list = obj_gameManager.m_sfxList;
var snd = audio_play_sound(argument0, 1, 0);

ds_list_add(list, snd);

return snd;
