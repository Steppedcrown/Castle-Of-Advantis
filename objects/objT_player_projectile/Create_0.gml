// Proj stats
projSpd = 1;
projDamage = 1;

// Bow charge
chargeable = global.player.chargeable;
chargedCount = global.player.attackChargeTimer / 60;

// Gravity
affectedByGrav = false;
grav = 0;
maxY = 0;

// Calculate absolute distances
xdist = abs(x - mouse_x);
ydist = abs(y - mouse_y);
// Set Euclidean difference
dist = sqrt(sqr(xdist) + sqr(ydist));
// Standardize values
xdist /= dist;
ydist /= dist;

// X Direction
moveDirX = global.player.face;

// Y direction
if mouse_y > y {moveDirY = 1;}
else if mouse_y < y {moveDirY = -1;}
else {moveDirY = 0;}

// Misc
destroyed = false;
startUpFrame = true;