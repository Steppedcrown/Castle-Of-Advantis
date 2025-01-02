// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	// Get abs distance to player
	var _xToPlayer = x + (global.player.x * -face);
	var _yToPlayer = abs(y - global.player.y);
	
	// Attack cooldown
	if !canShoot {
		attackTimer++;
		if attackTimer >= attackSpd {canShoot = true;}
	}
	
	// Check if player is in range
	if _xToPlayer <= rangeX && _xToPlayer >= 0 && _yToPlayer <= rangeY && canShoot {
		// Set x/y offset
		var _x = x - (16 * face);
		var _y = y + 10;
		// Create proj
		createProj(projectile, rangeX, rangeY, damage, projSpd, _y, _x);
		// Set active
		setActive(shootSpr, shootFrames);
		// Reset status
		attackTimer = 0;
		canShoot = false;
		awake = true;
	}
	
	/*---------------------------------- Spirte Control ----------------------------------*/
	if !active {sprite_index = idleSpr;}
	else {sprite_index = shootSpr;}
}