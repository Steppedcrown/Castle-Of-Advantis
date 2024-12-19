// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	
	// Cooldowns
	if !canAttack {
		attackCooldownTimer++;
		if attackCooldownTimer >= attackCooldown {canAttack = true; attackCooldownTimer = 0;}
	}
	if !canShoot {
		shootCooldownTimer++;
		if shootCooldownTimer >= shootCooldown {canShoot = true; shootCooldownTimer = 0;}
	}
	if !canAction {
		actionCooldownTimer++;
		if actionCooldownTimer >= actionCooldown {canAction = true; actionCooldownTimer = 0;}
	}
	
	// Find absolute distance to player
	var _xToPlayer = abs(global.player.x - x);
	var _yToPlayer = abs(global.player.y - y);
	
	// Check if player is detected
	if !detected && _xToPlayer <= detectionRange && _yToPlayer <= detectionRange {
		detected = true;
	}
	
	/*---------------------------------- Activating ----------------------------------*/
	if sleeping && detected {
		sleeping = false;
		setActive(wakingSpr, wakingFrames);
	}
	
	/*---------------------------------- Melee ----------------------------------*/
	// Reverse face
	face *= -1;
	if canAttack && canAction && !headless && !ensnared && !active && detected && _xToPlayer <= meleeRangeX && _yToPlayer <= meleeRangeY {
		// Set attacking vars
		setActive(attackSpr, attackFrames);
		canAttack = false;
		// Set attacking obj
		var _attack = instance_create_depth(x, y - sprite_height/2, depth, attackObj);
		with (_attack) {
			damage = other.meleeDamage;
			parent = other;
			image_xscale = other.face;
		}
	}
	
	/*---------------------------------- Shooting ----------------------------------*/
	if !active && !ensnared && detected {
		// Fire in the hole
		if activeSpr = headAttackSpr {
			var _head = createProj(proj, shootRangeX, shootRangeY, headDamage, projSpd);
			_head.parent = self;
		}
		// Initialize shot
		else if canShoot && canAction && _xToPlayer <= shootRangeX && _yToPlayer <= shootRangeY {
			setActive(headAttackSpr, shootingFrames);
			headless = true;
		}
	}
	
	/*---------------------------------- Movement ----------------------------------*/
	if !active && detected && !ensnared && _xToPlayer > meleeRangeX {
		if global.player.x + xPad < x {moveDirX = -1;}
		else if global.player.x - xPad > x {moveDirX = 1;}
		else {moveDirX = 0;}
		// Set x speed
		xspd = moveSpd * moveDirX;
		// Slopes
		if place_meeting(x+xspd, y, obj_wall) {
			var _total = 0;
			while !place_meeting(x+moveDirX, y-3, obj_wall) && _total < abs(xspd) {x += moveDirX; _total += 1;}
			y -= 3;
		}
		else {x += xspd}
		setActive(walkSpr, 1);
	}
	
	/*---------------------------------- Gravity ----------------------------------*/
	if !ensnared {
		if !place_meeting(x, y + grav, obj_wall) {y += grav;}	
	}
	
	/*---------------------------------- Sprite Control ----------------------------------*/
	if sleeping {sprite_index = sleepSpr;}
	else if !active {sprite_index = idleSpr;}
	else {sprite_index = activeSpr;}
}