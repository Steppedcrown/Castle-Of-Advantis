// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	
	// Cooldowns
	if !canAttack {
		attackCooldownTimer++;
		if attackCooldownTimer >= attackCooldown {canAttack = true; attackCooldownTimer = 0;}
	}
	
	// Find absolute distance to player
	var _xToPlayer = abs(global.player.x - x);
	var _yToPlayer = abs(global.player.y - y);
	
	// Check if player is detected
	if !detected && _xToPlayer <= detectionRange && _yToPlayer <= detectionRange {
		detected = true;
	}
	
	/*---------------------------------- Attacking ----------------------------------*/
	// Reverse face
	face *= -1;
	if canAttack && !ensnared && !active && detected && _xToPlayer <= attackRangeX && _yToPlayer <= attackRangeY {
		// Set attacking vars
		setActive(attackSpr, attackFrames);
		canAttack = false;
		// Set attacking obj
		var _attack = instance_create_depth(x, y - sprite_height/2, depth, attackObj);
		with (_attack) {
			damage = other.damage;
			parent = other;
			image_xscale = other.face;
		}
	}
	
	/*---------------------------------- Movement ----------------------------------*/
	if !active && detected && !ensnared && _xToPlayer > attackRangeX {
		if global.player.x + xPad < x {moveDirX = -1;}
		else if global.player.x - xPad > x {moveDirX = 1;}
		else {moveDirX = 0;}
		// Set x speed
		xspd = moveSpd * moveDirX;
		// Slopes
		if place_meeting(x+xspd, y, obj_wall) {
			var _total = 0;
			while !place_meeting(x+moveDirX, y-abs(xspd), obj_wall) && _total < abs(xspd) {x += moveDirX; _total += 1;}
			if _total != 0 {y -= abs(xspd);}
			else {xspd = 0;}
		}
		else {x += xspd}
		if xspd != 0 {setActive(walkSpr, 1);}
	}
	
	/*---------------------------------- Gravity ----------------------------------*/
	if !ensnared {
		if !place_meeting(x, y + grav, obj_wall) {y += grav;}	
	}
	
	/*---------------------------------- Sprite Control ----------------------------------*/
	if !active {sprite_index = idleSpr;}
	else {sprite_index = activeSpr;}
}