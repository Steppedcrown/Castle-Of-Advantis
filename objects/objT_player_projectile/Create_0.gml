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
grav = global.player.grav;
//maxY = 0;
// Super proj
affectedByGravSuper = global.player.affectedByGrav;
gravSuper = global.player.grav;

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