///draw_bezier(x1, y1, x2, y2, x3, y3)

// Draws a bezier
// also returns array with positions of the middle of the curve

//first
x1 = argument0;
y1 = argument1;

//second
x2=argument2;
y2=argument3;

//middle
x3 = argument4;
y3 = argument5;

MX = x1;
MY = y1;

middle[0] = 0;

//draw
for(pr = 0; pr <= 1; pr += 0.01)
{
    Qx1=(x2-x1)*pr+x1
    Qy1=(y2-y1)*pr+y1;
    Qx2=(x3-x2)*pr+x2;
    Qy2=(y3-y2)*pr+y2;
    QX=(Qx2-Qx1)*pr+Qx1;
    QY=(Qy2-Qy1)*pr+Qy1;
    
    draw_line(QX,QY,MX,MY)
    MX=QX;
    MY=QY;
    
    if(pr == 0.5)
    {
        middle[0] = QX;
        middle[1] = QY;
    }
}

return middle;
