if startUpFrame {
	startUpFrame = false;
	// Multiple by projSpd
	xspd = xdist * projSpd;
	yspd = ydist * projSpd;
	maxY = yspd;
}

// Account for gravity
if affectedByGrav {
	gravTimer++;
	if gravTimer >= gravCount {
		// Proj moving up
		if moveDirY < 0 {
			yspd *= grav;
			if yspd < minY {yspd *= 0.25;}
			if yspd < 0.15 {moveDirY = 1;}
		}
		// Proj moving down
		else {
			// If it is still below the max speed
			if yspd/grav < maxY {yspd /= grav;}
		}
	}
}

// Move
x += xspd * moveDirX;
y += yspd * moveDirY;

// Destroy and damage when hitting enemy
var _enemyHit = instance_place(x, y, objT_enemy)
if _enemyHit {
	_enemyHit.hp -= projDamage;
	destroyed = true;
}
// Destroy when out of room or hitting a wall
else if x < 0 || x > room_width 
|| y < 0 || y > room_height
|| place_meeting(x, y, obj_wall) {
	destroyed = true;
}

// Destroy projectile
if destroyed {instance_destroy();}