// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	// Reset cooldowns
	if !canJump {
		jumpCooldownTimer++;
		if jumpCooldownTimer >= jumpCooldown {canJump = true; jumpCooldownTimer = 0;}
	}
	if !canShoot {
		shootCooldownTimer++;
		if shootCooldownTimer >= shootCooldown {canShoot = true; shootCooldownTimer = 0;}
	}
	
	// Find absolute distance to player
	var _xToPlayer = abs(global.player.x - x);
	var _yToPlayer = abs(global.player.y - y);
	
	// Check if player is detected
	if !detected && _xToPlayer <= detectionRange && _yToPlayer <= detectionRange {
		detected = true;
	}	
	
	/*---------------------------------- Jumping ----------------------------------*/
	// Check if player is in range
	
	// Move if not doing anything else
	if !active && detected {
		/*---------------------------------- Face Player ----------------------------------*/
		if global.player.x < x {moveDirX = -1;}
		else if global.player.x > x {moveDirX = 1;}
		else {moveDirX = 0;}
		// Set x speed
		xspd = moveSpd * moveDirX;
		x += xspd;
	}
	/*---------------------------------- Sprite Control ----------------------------------*/
	if !active {sprite_index = idleSpr;}
	else {sprite_index = activeSpr;}
}