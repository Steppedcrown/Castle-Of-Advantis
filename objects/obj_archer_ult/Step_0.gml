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

// Move
x += xspd * moveDirX;
y += yspd * moveDirY;

// Destroy and damage when hitting enemy
var _enemyHit = instance_place(x, y, objT_enemy)
if _enemyHit {
	_enemyHit.hp -= projDamage;
	_enemyHit.ensnared = true;
	_enemyHit.ensnaredDuration = ensnaredDuration;
	destroyed = true;
}
// Destroy when out of room or hitting a wall
else if x < 0 || x > room_width 
|| y < 0 || y > room_height
|| place_meeting(x, y, obj_wall) 
{
	destroyed = true;
}

// Destroy projectile
if destroyed {instance_destroy();}