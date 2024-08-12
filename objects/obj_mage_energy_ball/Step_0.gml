// Move
x += xspd * moveDirX;
y += yspd * moveDirY;

// Destroy and damage when hitting enemy
var _enemyHit = instance_place(x, y, objT_enemy)
if _enemyHit {
	_enemyHit.hp -= projDamage;
	destroyed = true;
}
// Destroy when out of room
else if x < 0 || x > room_width 
|| y < 0 || y > room_height {
	destroyed = true;
}

// Destroy projectile
if destroyed {instance_destroy();}