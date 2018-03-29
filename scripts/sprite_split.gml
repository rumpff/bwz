/// sprite_split(spr, ds_listA, ds_listB, spr_x, spr_y, x1, y1, x2, y2, mustintersect, complex)
/*
    Separates a sprite into 2 sprites by cutting a line through the original sprite
    If you require the sprites to have accurate dimensions, see sprite_split_real_dimensions()
    
    Arguments:
        spr             sprite
        ds_list         list that will contain return value
        spr_x,y         sprite's screen coordinates
        x1,y1           line start point
        x2,y2           line end point
        mustintersect   true if the line must touch two edges of the bbox, otherwise it's also valid within the bbox
        complex         true if complex (precise) algorithm, else false (may leave visual artifacts)
    
    Returns:
        true if successful, else false
        Sprites are returned via the "ds_list" argument
        This argument functions like an "out parameter" or a pointer
        You pass a ds_list into it, and if the script returns true, the ds_list will contain the two sprites
        For further explanation, see included demo objects
        
    Out of bounds:
        The intersecting line is out of bounds if it is not within the sprite's bounding box
        See mustintersect
        
    Script by Jobo on the YoYo Games Marketplace
*/

var spr = argument0;
var listA = argument1;
var listB = argument2;
var spr_x = argument3, spr_y = argument4;
var x1 = argument5, y1 = argument6;
var x2 = argument7, y2 = argument8;
var mustintersect = argument9;
var complex = argument10;

// Clear list * rumpf edit: don't
//ds_list_clear(list);

if(x1 == x2 && y1 == y2) {
    // 1 point does not make a line
    return false;
}

// Get draw state so we can preserve the properties we alter
var draw_color = draw_get_color();
// Set rendering color during this script's rendering procedures
draw_set_color(c_black);

// Get sprite properties
var width = sprite_get_width(spr);
var height = sprite_get_height(spr);
var xoffset = sprite_get_xoffset(spr);
var yoffset = sprite_get_yoffset(spr);
var bb_left = sprite_get_bbox_left(spr);
var bb_top = sprite_get_bbox_top(spr);
var bb_right = sprite_get_bbox_right(spr);
var bb_bottom = sprite_get_bbox_bottom(spr);

if(x2 < x1) {
    // The cut goes from right to left, 
    // so we swap x- and y-coordinates
    var tx1 = x1, ty1 = y1;
    x1 = x2;
    x2 = tx1;
    y1 = y2;
    y2 = ty1;
}

// Get the sprite's real coordinate position
var delta_x = spr_x - xoffset;
var delta_y = spr_y - yoffset;

// Do a fast test to check if the intersecting line is out of bounds
if(min(x1, x2) >= delta_x + width || min(y1, y2) >= delta_y + height || max(x1, x2) <= delta_x || max(y1, y2) <= delta_y) {
    // There's no possible outcome of a valid intersection with this line
    // This line is out of bounds
    return false;
}

// Convert from screen to sprite coordinates
x1 = x1 - delta_x;
x2 = x2 - delta_x;
y1 = y1 - delta_y;
y2 = y2 - delta_y;

if(mustintersect) {
    // If both ends of the line are within the sprite's bounding box,
    // then the line is invalid and we will not use it to split the sprite (even though we can)
    if(point_in_rectangle(x1, y1, bb_left, bb_top, bb_right, bb_bottom)
       || point_in_rectangle(x2, y2, bb_left, bb_top, bb_right, bb_bottom)) {
        // One or all points are within the bounding box
        // Hence it does not intersect two edges, and is therefore invalid
        return false;
    }
}

// y = a*x + b
// y = m*x + b
// Avoid division by zero
var a = (y2 - y1) / max(1, (x2 - x1));
var b = y2 - a * x2;

// Create a temporary alpha map
var alpha_map = surface_create(width, height);
// Set target to alpha map
surface_set_target(alpha_map);
// Fill the alpha map with alpha value 255
draw_clear(c_white);

var found_point_in_bbox = false;
// Render the alpha map
// Iterate through all points in the line by x-coordinate
for(var i = 0; i < width + 1; i++) {
    // Get the corresponding y-coordinate of this x-coordinate on the line
    var cy = a * i + b;
    // Draw a straight line from (i,-1) down to (i,cy)
    draw_line(i, -1, i, cy);
    
    if(!found_point_in_bbox) {
        if(point_in_rectangle(i, cy, bb_left, bb_top, bb_right, bb_bottom) || (x1 >= x2 - 1 && x1 <= x2 + 1)) {
            // If the condition x1 == x2 is satisfied, it's a vertical split
            // and we assume it's valid based on earlier point-based checks that confirmed that both y-coordinates
            // are within the sprite
            // This point is within the bounding box of this sprite
            // That means it's a valid intersection
            found_point_in_bbox = true;
        }
    }
}

// Set target back to application surface, we're done rendering our alpha map
surface_reset_target();

if(!found_point_in_bbox) {
    // No point was found inside the bounding box
    // That means it's not a valid intersection, and we can't use it to split the sprite
    // Clean up all resources and return false from script
    surface_free(alpha_map);
    return false;
}

// Convert the alpha map to a sprite resource
var spr_alpha_map = sprite_create_from_surface(alpha_map, 0, 0, width, height, false, false, xoffset, yoffset);

// Now we get the first sprite of the two new sprites
// We get this by applying the above alpha map to the original sprite
var new_spr_1 = sprite_duplicate(spr);
sprite_set_alpha_from_sprite(new_spr_1, spr_alpha_map);

// We no longer need the alpha map as a sprite resource
// Destroy it
sprite_delete(spr_alpha_map);

// Set target to the alpha map again
// We need to use it to create a second alpha map
// which is an inverted version of the original alpha map
surface_set_target(alpha_map);
// Clear the alpha map so we draw to a completely clean canvas
draw_clear_alpha(c_white, 0);

if(!complex) {
    // Simple algorithm
    // May leave visual artifacts depending on alpha values around edges
    // To create the second alpha map, we use a little trick
    // When we created the first sprite,
    // we got the part of the sprite we want to remove to create the second part of sprite
    // We know that c_black equals alpha value 0,
    // so we draw the first part of the sprite again, but we color it entirely black
    draw_sprite_stretched_ext(new_spr_1, 0, 0, 0, width, height, c_black, 1);
}
else {
    // Complex algorithm
    // This is pixel-precise and is therefore also slower
    // We employ the same method we used to create the first alpha map,
    // only flipped vertically this time
    // Iterate through all points in the line by x-coordinate
    for(var i = 0; i < width + 1; i++) {
        // Get the corresponding y-coordinate of this x-coordinate on the line
        var cy = a * i + b;
        // Draw a straight line from (i,cy) down to (i,height)
        draw_line(i, cy, i, height);
    }
}

// Set target back to application surface, we're done rendering our alpha map
surface_reset_target();

// Convert the new alpha map to a sprite resource
var spr_alpha_map_2 = sprite_create_from_surface(alpha_map, 0, 0, width, height, false, false, xoffset, yoffset);

// Now we get the second sprite of the two new sprites
// We get this by applying the new alpha map to the original sprite
var new_spr_2 = sprite_duplicate(spr);
sprite_set_alpha_from_sprite(new_spr_2, spr_alpha_map_2);

// We no longer need the new alpha map as a sprite resource
// Destroy it
sprite_delete(spr_alpha_map_2);
// Likewise we no longer need the alpha map either
// So we destroy that as well
surface_free(alpha_map);

// Add sprites to the out parameter ds_list * rumpf edit: add them to 2 seperate lists
ds_list_add(listA, new_spr_1);
ds_list_add(listB, new_spr_2);

// Re-apply original draw state
draw_set_color(draw_color);

// Script was successful
return true;
