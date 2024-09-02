if startUpFrame {
	startUpFrame = false;
	// Increase proj stats by charged amount
	if chargeable {
		projSpd += chargedCount;
		projDamage *= max(1, chargedCount);
	}
	// Multiple by projSpd
	xspd = xdist * projSpd;
	yspd = ydist * projSpd;
	maxY = yspd * 1.1;
}

// Account for gravity
if affectedByGrav {
	//if abs(yspd) < maxY {yspd -= grav;}
	if moveDirY == 1 {yspd += grav;}
	else {yspd -= grav;}
}

// Move on outgoing path
if outgoing {
	x += xspd * moveDirX;
	y += yspd * moveDirY;
}
else {
	// Calculate absolute distances
	xdist = abs(x - global.player.x);
	ydist = abs(y - global.player.y);
	// Set Euclidean difference
	dist = sqrt(sqr(xdist) + sqr(ydist));
	// Standardize values
	xdist /= dist;
	ydist /= dist;

	// X Direction
	if global.player.x > x {moveDirX = 1;}
	else if global.player.x < x {moveDirX = -1;}
	else {moveDirX = 0;}

	// Y direction
	if global.player.y > y {moveDirY = 1;}
	else if global.player.y < y {moveDirY = -1;}
	else {moveDirY = 0;}
	
	// Move
	x += xspd * moveDirX;
	y += yspd * moveDirY;
}

// Return and damage when hitting enemy
var _enemyHit = instance_place(x, y, objT_enemy)
if _enemyHit {
	_enemyHit.hp -= projDamage;
	outgoing = false;
}
// Return when out of room or hitting a wall
else if outgoing &&
(x < 0 || x > room_width 
|| y < 0 || y > room_height
|| place_meeting(x, y, obj_wall))
{
	outgoing = false;
}

// Destroy projectile
if !outgoing &&
abs(x - global.player.x) <= 10 &&
abs(y - global.player.y) <= 10 {
	global.player.hasSword = true;
	instance_destroy();
}