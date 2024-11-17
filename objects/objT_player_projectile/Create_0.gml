// Proj stats
// Basic
projSpd = global.player.projSpd;
projDamage = global.player.projDamage;

// Bow charge
chargeable = global.player.chargeable;
chargedCount = global.player.attackChargeTimer / 60;

// Gravity
// Basic proj
affectedByGrav = global.player.affectedByGrav;
gravProj = global.player.gravProj;

// Calculate absolute distances
xdist = abs(x - mouse_x);
ydist = abs(y - mouse_y);
// Set Euclidean difference
dist = sqrt(sqr(xdist) + sqr(ydist));
// Standardize values
xdist /= dist;
ydist /= dist;

/*
// Set x and y for angle
var _x = mouse_x - x;
var _y = mouse_y - y;
// Set angle depending on direction
if x < mouse_x {image_angle = arctan2(_y, _x) * -180 / pi;}
else {image_angle = arctan2(-_y, -_x) * -180 / pi;}
*/

// X Direction
moveDirX = global.player.face;

// Y direction
if mouse_y > y {moveDirY = 1;}
else if mouse_y < y {moveDirY = -1;}
else {moveDirY = 0;}

// Misc
destroyed = false;
startUpFrame = true;