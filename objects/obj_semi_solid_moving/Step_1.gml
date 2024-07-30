// Move in a circle
dir += rotSpd;

// Get target positions
var _targetX = xstart + lengthdir_x(radius, dir);
var _targetY = ystart + lengthdir_y(radius, dir);

// Get x and y spd
xspd = _targetX - x;
yspd = _targetY - y;

// Move
x += xspd;
//y += yspd;