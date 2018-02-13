///collision_line_multiple(x1, y1, x2, y2, x3, y3, amount, target, perfect)

/***********************************************************
  x1 & y1 = The upper left starting point of the rays
  
  x2 & y2 = The upper right ending point of the row of rays 
  
  x3 & y3 = The lower left ending point of the first ray
  
  amount = The amount of rays
  target = The target object of the collision
  perfect = If the collision is perfect or not (docs)
 ***********************************************************/

startX = argument0;
startY = argument1;
endX = argument2;
endY = argument3;
lineEndX = argument4;
lineEndY = argument5;

rayAmount = argument6;
rayTarget = argument7;
rayPerfect = argument8;

spacingX = (((endX - startX) - rayAmount) / rayAmount);
spacingY = (((endY - startY) - rayAmount) / rayAmount);

for (i = 0; i < rayAmount; i++)
{
   if (collision_line(startX + (i * spacingX), startY + (i * spacingY), 
                           lineEndX + (i * spacingX), lineEndY + (i * spacingY), 
                           rayTarget, rayPerfect, false))
                           
                           {
                                    return true;
                           }
}

return false;
