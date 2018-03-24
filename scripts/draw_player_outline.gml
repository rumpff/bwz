///draw_outline_player(playerID, distance)

var surfId = argument0;
var distance = argument1;
var color = global.playerColor[surfId];

// For performance this should be as small as the image you want to draw including the border 
if (!surface_exists(global.surfacehole[surfId])) {global.surfacehole[surfId] = surface_create(room_width, room_height); }
if (!surface_exists(global.surfaceoutline[surfId])) {global.surfaceoutline[surfId] = surface_create(room_width, room_height); }

surface_set_target(global.surfacehole[surfId]); /// draw onto the punch out surface

draw_set_blend_mode(bm_subtract); // dont draw image but remove the inverse from what we are drawing onto 
draw_clear(c_black); // clear anything from the previous frame in case the image is being animated 

// draw all the sprites on with a little offset to make a border
for (i = 0; i < 16; i++)
{   
    var xOff = lengthdir_x(distance, i*(45/2));
    var yOff = lengthdir_y(distance, i*(45/2));
    
    // Draw the player
    // Left leg
    draw_sprite_ext(m_legSprite, 0, m_legRX + xOff, m_legRY + m_legLYOff + yOff, 
        m_imageDirection, 1, m_legRA, c_black, 1);
        
    // Right leg
    draw_sprite_ext(m_legSprite, 0, m_legLX + xOff, m_legLY + m_legRYOff + yOff, 
        m_imageDirection, 1, m_legLA, c_black, 1);
    
    // Draw the body
    draw_sprite_ext(m_headSprite, 0, x + xOff, y + m_bodyOffsetY + yOff,
        m_imageDirection, 1, m_bodyAngle, c_black, 1);
        
    // Draw the hat
    draw_player_hat(xOff, yOff, c_black);

}

// set all the drawing modes back to normal 
draw_set_blend_mode(bm_normal);
surface_reset_target();

surface_set_target(global.surfaceoutline[surfId]); // make the surface that will become the outline

draw_sprite_tiled_ext(spr_outlineTexture, 0, x, y, 1, 1, color, 1); // fill this surface with whatever we want to be displayed 

draw_set_blend_mode(bm_subtract);
draw_surface(global.surfacehole[surfId],0,0); // punch out everything outside the border 
draw_set_blend_mode(bm_normal);

surface_reset_target();
draw_surface_ext(global.surfaceoutline[surfId], 0, 0, 1, 1, 0, c_white, 1);
