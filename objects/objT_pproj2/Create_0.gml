// Get max height of parabola
vertexY = mouse_y;
projSpd = 0;

fast = 0;
xdist = x - mouse_x;
if abs(xdist) > 150 {xspd = 2; fast = 1;}
else {xspd = 1; fast = 2;}

ydist = y - mouse_y;
if ydist >= 0 {
	yspd = vertexY + 5;
	fast += 2;
	if ydist > 150 {yspd += 5; fast += 3;}
}
else {
	xspd = 1;
	yspd = vertexY - 1;
	fast += 1;
	if ydist < -150 {yspd -= 1; fast += 2;}
}

if xdist < 0 {xspd *= -1; fast = -1;}

originY = fast + vertexY;

destroyed = false;