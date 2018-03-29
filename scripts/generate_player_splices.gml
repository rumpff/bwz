/// generate_player_splices()

// Generates player splices and puts them in a list

// Save the sprite index for later
var spriteOld = sprite_index;

for (i = 0; i < global.playerAmount; i++)
{
    sprite_index = head_sprite(global.playerHead[i]);
    
    for (ii = 0; ii < 360; ii++)
    {
        var xOff1 = lengthdir_x(64, ii);
        var yOff1 = lengthdir_y(64, ii);
        
        var xOff2 = lengthdir_x(64, ii+180);
        var yOff2 = lengthdir_y(64, ii+180);
        
        sprite_split(sprite_index, global.playerPartA[i], global.playerPartB[i], x, y, x + xOff1, y + yOff1, x + xOff2, y + yOff2, false, true);
    }
}

sprite_index = spriteOld;  
