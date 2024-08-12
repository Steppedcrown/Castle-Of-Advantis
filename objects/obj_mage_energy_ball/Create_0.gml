// Get head angle
angle = global.player.playerHead.angle;

// Proj stats
projSpd = 200;
projDamage = 1;

// Move speeds
xdist = abs(x - mouse_x);
ydist = abs(y - mouse_y);
xspd = (xdist / (xdist * ydist)) * projSpd;
yspd = (ydist / (xdist * ydist)) * projSpd;

// X Direction
if mouse_x > x {moveDirX = 1;}
else if mouse_x < x {moveDirX = -1;}
else {moveDirX = 0;}
//moveDirX = global.player.face;

// Y direction
if mouse_y > y {moveDirY = 1;}
else if mouse_y < y {moveDirY = -1;}
else {moveDirY = 0;}

// Misc
destroyed = false;