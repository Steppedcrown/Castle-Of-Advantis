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
	// Jump
	if activeSpr == jumpSpr {
		// Damage player
		if place_meeting(x, y, global.player) && canDamage {global.player.hp -= jumpDamage; canDamage = false;}
		// Check if spider is past midpoint
		if (jumpDirX > 0 && x >= midpoint) || (jumpDirX < 0 && x <= midpoint) {jumpDirY *= -1;}
		// Move for jump
		x += jumpSpd * jumpDirX;
		y += sqr(jumpSpd) * jumpDirY;
		// Determine whether or not to stop jumping
		if (jumpDirX > 0 && x >= targetX) || (jumpDirX < 0 && x <= targetX) {
			// Reset variables
			canJump = false;
			setInactive();
		}
	}
	if !active {
		// Initialize jump
		if activeSpr == holdSpr {
			// Set variables
			canDamage = true;
			setActive(jumpSpr, 6969);
			// Log player coords
			targetX	= global.player.x;
			targetY = global.player.y;
			// Determine jump direction
			midpoint = (targetX - x) / 2;
			if midpoint > 0 {jumpDirX = 1;}
			else {jumpDirX = -1;}
			// Determine midpoint
			midpoint += x;
		}
		// Check if player is in jumping range and hold
		else if canJump && _xToPlayer <= jumpRange && _yToPlayer <= jumpRange {
			setActive(holdSpr, holdFrames);
		}
	}
	
	/*---------------------------------- Movement ----------------------------------*/
	if !active && detected {
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