// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	// Get abs distance to player
	var _xToPlayer = abs(x - global.player.x);
	var _yToPlayer = abs(y - global.player.y);
	
	// Attack cooldown
	if !canShoot {
		attackTimer++;
		if attackTimer >= attackSpd {canShoot = true;}
	}
	
	// Check if player is in range
	if _xToPlayer <= rangeX && _yToPlayer <= rangeY && canShoot {
		// Create proj
		createProj(projectile, rangeX, rangeY, damage, projSpd);
		// Reset status
		attackTimer = 0;
		canShoot = false;
	}
}