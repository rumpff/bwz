/// sprite_split_real_dimensions(spr,ds_list,spr_x,spr_y,x1,y1,x2,y2,mustintersect)
/*
    Separates a sprite into 2 sprites by cutting a line through the original sprite
    The two generated sprites have pixel-precise dimensions (width, height) and are perfect for physics usage
    
    Arguments:
        spr             sprite
        ds_list         list that will contain return value
        spr_x,y         sprite's screen coordinates
        x1,y1           line start point
        x2,y2           line end point
        mustintersect   true if the line must touch two edges of the bbox, otherwise it's also valid within the bbox
    
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
var list = argument1;
var spr_x = argument2, spr_y = argument3;
var x1 = argument4, y1 = argument5;
var x2 = argument6, y2 = argument7;
var mustintersect = argument8;

// Clear list
ds_list_clear(list);

if(x1 == x2 && y1 == y2) {
    // 1 point does not make a line
    return false;
}

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

// Create a temporary surface
var surface = surface_create(width, height);
// Set target to surface
surface_set_target(surface);
// Clear the surface from any garbage that may be on it
draw_clear_alpha(c_white, 0);

var rx = 0, rw = 0, rh = 0;
var hasx = false, hasw = false;
var found_point_in_bbox = false;
// Render the first sprite
// Iterate through all points in the line by x-coordinate
for(var i = 0; i < width + 1; i++) {
    // Get the corresponding y-coordinate of this x-coordinate on the line
    var cy = max(0, a * i + b);
    // Draw a straight line from (i,-1) down to (i,cy)
    draw_sprite_part(spr, 0, i, 0, 1, cy, i, 0);
    
    /*
        Sprite vertical dimension
    */
    if(cy > rh)
        // Get the height of the new sprite
        rh = cy;
    
    /*
        Sprite horizontal dimension
    */
    if(cy > 0 && !hasx) {
        // Get the x-coordinate of the new sprite
        rx = i;
        hasx = true;
    }
    else if(cy < 0 && !hasw) {
        // Get the width of the new sprite
        rw = i;
        hasw = true;
    }
    
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

/*
    Sprite vertical dimension
*/
if(rh > height)
    // Fix the height variable
    rh = height;

/*
    Sprite horizontal dimension
*/
if(rw == 0)
    // Fix width variable
    rw = width - rx;

// Set target back to application surface, we're done rendering the first sprite
surface_reset_target();

if(!found_point_in_bbox) {
    // No point was found inside the bounding box
    // That means it's not a valid intersection, and we can't use it to split the sprite
    // Clean up all resources and return false from script
    surface_free(surface);
    return false;
}

// Convert the surface to a sprite resource
// This is where the precise dimensions are applied to the image
var sprite_first = sprite_create_from_surface(surface, rx, 0, rw, rh, false, false, xoffset, yoffset);

// Set target to the surface again
// We need to use it to create the second sprite
surface_set_target(surface);
// Clear the surface so we draw to a completely clean canvas
// and not on top of the previous sprite
draw_clear_alpha(c_white, 0);

// Reuse temporary variables from earlier
hasx = false;
hasw = false;
rx = 0;
rw = 0;
rh = 0;
var ry = height;

// We employ the same method we used to create the first sprite,
// only flipped vertically this time
// Iterate through all points in the line by x-coordinate
for(var i = 0; i < width + 1; i++) {
    // Get the corresponding y-coordinate of this x-coordinate on the line
    var cy = max(0, (a * i + b));
    // Draw a straight line from (i,cy) down to (i,height)
    draw_sprite_part(spr, 0, i, cy, 1, height, i, cy);
    
    /*
        Sprite vertical dimension
    */
    if(cy < ry)
        // Get the y-coordinate of the new sprite
        ry = cy;
    
    /*
        Sprite horizontal dimension
    */
    if(cy > 0 && !hasx) {
        // Get the x-coordinate of the new sprite
        rx = i;
        hasx = true;
    }
    else if(cy > height && !hasw) {
        // Get the width of the new sprite
        rw = i;
        hasw = true;
    }
}

/*
    Sprite vertical dimension
*/
// Fix the height variable
rh = height - ry;

/*
    Sprite horizontal dimension
*/
if(rw == 0)
    // Fix width variable
    rw = width - rx;

// Set target back to application surface, we're done rendering our alpha map
surface_reset_target();

// Convert the surface to a sprite resource
// This is where the precise dimensions are applied to the image
var sprite_second = sprite_create_from_surface(surface, 0, ry, width, rh, false, false, xoffset, yoffset);

// We no longer need the surface,
// so we free it from memory
surface_free(surface);

// Add the sprites to the out parameter ds_list
ds_list_add(list, sprite_first, sprite_second);

// Script was successful
return true;
