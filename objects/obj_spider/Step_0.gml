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
	if !canDoAction {
		actionCooldownTimer++;
		if actionCooldownTimer >= actionCooldown {canDoAction = true; actionCooldownTimer = 0;}
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
		if (jumpDirX > 0 && x >= midpoint) || (jumpDirX < 0 && x <= midpoint) {jumpDirY = 1;}
		// Set jumping movement variables
		var _xspd = jumpSpd * jumpDirX;
		var _yspd = sqr(jumpSpd) * jumpDirY;
		var _stopJumping = false;
		// Jump or stop jump if blocked on X
		if !place_meeting(x+_xspd, y, obj_wall) {x += _xspd;}
		else {_stopJumping = true;}
		// And on Y
		if !place_meeting(x, y+_yspd, obj_wall) {y += _yspd;}
		else {_stopJumping = true;}
		// Determine whether or not to stop jumping
		if _stopJumping { //|| (jumpDirX > 0 && x >= targetX) || (jumpDirX < 0 && x <= targetX)
			// Reset variables
			jumping = false;
			canJump = false;
			canDoAction = false;
			setInactive();
		}
	}
	if !active && !shooting {
		// Initialize jump
		if activeSpr == holdSpr {
			// Set variables
			jumping = true;
			jumpDirY = -1;
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
		else if detected && canDoAction && canJump && _xToPlayer <= jumpRange && _yToPlayer <= jumpRange {
			setActive(holdSpr, holdFrames);
		}
	}
	
	/*---------------------------------- Shooting ----------------------------------*/
	if !active {
		// Fire proj
		if activeSpr == shootSpr {
			shooting = false;
			canShoot = false;
			canDoAction = false;
			setInactive();
			createProj(projectile, projRange, projRange, projDamage, projSpd, y-5, x-(5*face));
		}
		// Check if player is in range and begin shoot animation
		else if detected && canDoAction && canShoot && _xToPlayer <= projRange && _yToPlayer <= projRange {
			shooting = true;
			setActive(shootSpr, shootFrames);
		}
	}
	
	/*---------------------------------- Movement ----------------------------------*/
	if !active && detected {
		if global.player.x + xPad < x {moveDirX = -1;}
		else if global.player.x - xPad > x {moveDirX = 1;}
		else {moveDirX = 0;}
		// Set x speed
		xspd = moveSpd * moveDirX;
		if !place_meeting(x+xspd, y, obj_wall) {x += xspd};
	}
	
	/*---------------------------------- Gravity ----------------------------------*/
	if !jumping {
		if !place_meeting(x, y + grav, obj_wall) {y += grav;}	
	}
	
	/*---------------------------------- Sprite Control ----------------------------------*/
	if !active {sprite_index = idleSpr;}
	else {sprite_index = activeSpr;}
}