// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	// Reset cooldowns
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
	
	if detected && setAttackNum {
		attackNum = round(random_range(0, 1));
		setAttackNum = false;
	}
	
	/*---------------------------------- Jumping ----------------------------------*/
	if !ensnared && canDoAction && attackNum == 0 {
		// Jump
		if activeSpr == jumpSpr {
			// Damage player
			if place_meeting(x, y, global.player) && canDamage {global.player.hp -= jumpDamage; canDamage = false;}
			// Check if spider is past midpoint
			if (jumpDirX > 0 && x >= midpoint) || (jumpDirX < 0 && x <= midpoint) {jumpDirY = 1;}
			// Set jumping movement variables
			var _xspd = jumpSpd * jumpDirX;
			var _yspd = sqr(_xspd) * jumpDirY / 1.5;
			var _stopJumping = false;
			// Jump or stop jump if blocked on X
			if !place_meeting(x+_xspd, y+_yspd, obj_wall) {x += _xspd; y += _yspd;}
			else {
				_stopJumping = true;}
			// Determine whether or not to stop jumping
			if _stopJumping { //|| (jumpDirX > 0 && x >= targetX) || (jumpDirX < 0 && x <= targetX)
				// Reset variables
				jumping = false;
				canDoAction = false;
				setInactive();
				setAttackNum = true;
			}
		}
		// Once hold animation ends
		else if !active && jumping {
			// Initialize jump and set variables
			jumpDirY = -1;
			canDamage = true;
			setActive(jumpSpr, -1);
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
		else if !active && _xToPlayer <= jumpRange && _yToPlayer <= jumpRange && place_meeting(x, y+5, obj_wall) {
			setActive(holdSpr, holdFrames);
			jumping = true;
		}
	}
	/*---------------------------------- Shooting ----------------------------------*/
	if canDoAction && attackNum == 1 {
		// Fire proj
		if activeSpr == shootSpr {
			// Create proj
			createProj(projectile, projRange, projRange, projDamage, projSpd, y-5, x-(5*face));
			// Reset variables
			shooting = false;
			canDoAction = false;
			setInactive();
			setAttackNum = true;
		}
		// Check if player is in range and begin shoot animation
		else if _xToPlayer <= projRange && _yToPlayer <= projRange {
			setActive(shootSpr, shootFrames);
			shooting = true;
		}
	}
	
	/*---------------------------------- Movement ----------------------------------*/
	if !active && detected && !ensnared {
		if x < global.player.x - xPad {moveDirX = 1;}
		else if x > global.player.x + xPad {moveDirX = -1;}
		else {moveDirX = 0;}
		// Set x speed
		xspd = moveSpd * moveDirX;
		if moveDirX != 0 {
			// Slopes
			if place_meeting(x+xspd, y, obj_wall) {
				var _total = 0;
				while !place_meeting(x+moveDirX, y-3, obj_wall) && _total < abs(xspd) {x += moveDirX; _total += 1;}
				y -= 3;
			}
			else {x += xspd}
			setActive(walkSpr, 1);
		}
	}
	
	/*---------------------------------- Gravity ----------------------------------*/
	if !jumping && !ensnared {
		if !place_meeting(x, y + grav, obj_wall) {y += grav;}	
	}
	
	/*---------------------------------- Sprite Control ----------------------------------*/
	if !active {sprite_index = idleSpr;}
	else {sprite_index = activeSpr;}
}