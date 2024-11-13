// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	
	/*---------------------------------- Attacking ----------------------------------*/
	// Find absolute distance to player
	var _xToPlayer = abs(global.player.x - x);
	var _yToPlayer = abs(global.player.y - y);
	//// Begin attack if within range
	//if canAttack && (_xToPlayer <= attackRange || _yToPlayer <= attackRange) && (!sleeping || !waking) {
	//	if !startingAttack && !attacking {
	//		startingAttack = true;
	//		canDamage = true;
	//		// Set attackDirX
	//		if global.player.x < x {attackDirX = -1;}
	//		else {attackDirX = 1;}
	//	}
	//}
	//// Count attack startup frames
	//if startingAttack {
	//	startingTimer++
	//	if startingTimer >= startingCount {startingAttack = false; attacking = true; startingTimer = 0;}
	//}
	//else if attacking {
	//	// Damage player
	//	if place_meeting(x, y, global.player) && canDamage {global.player.hp -= damage; canDamage = false;}
	//	var _attackDist = attackMoveSpd * attackDirX
	//	attackDistX += abs(_attackDist);
	//	if attackDistX < attackDistTotal {x += _attackDist;}
	//	else {attacking = false; attackDistX = 0; canAttack = false;}
	//}
	
	//// Attacking cooldown
	//if !canAttack {attackCooldownTimer++;}
	//if attackCooldownTimer >= attackCooldown {canAttack = true; attackCooldownTimer = 0;}
	
	///*---------------------------------- Movement ----------------------------------*/
	//// Clear move directions
	//moveDirX = 0;
	//moveDirY = 0;
	//// If player is within detection range move towards them
	//if _xToPlayer <= detectionRange && _yToPlayer <= detectionRange {
	//	// If asleep, wake up
	//	if sleeping || waking {
	//		sleeping = false;
	//		waking = true;
	//		wakingTimer++;
	//		if wakingTimer >= wakingCount {waking = false; wakingTimer = 0;}
	//	}
	//	// If not attacking move towards them
	//	else if !startingAttack && !attacking {
	//		// Set moveDirX
	//		if global.player.x < x {moveDirX = -1;}
	//		else {moveDirX = 1;}
	//		// Set moveDirY
	//		if global.player.y < y {moveDirY = -1;}
	//		else {moveDirY = 1;}
	//	}
	//}
	
	// Clear move directions
	moveDirX = 0;
	moveDirY = 0;
	
	// If player is within detection range
	if !active && _xToPlayer <= detectionRange && _yToPlayer <= detectionRange {
		// Either wake up
		if sleeping {
			setActive(wakeUpSpr, wakingFrames);
			sleeping = false;
		}
		// Or set moveDirs towards player
		else {
			// Set moveDirX
			if global.player.x < x {moveDirX = -1;}
			else {moveDirX = 1;}
			// Set moveDirY
			if global.player.y < y {moveDirY = -1;}
			else {moveDirY = 1;}
		}
	}
	
	// Attack
	if active && activeSpr == attackSpr {
		if place_meeting(x, y, global.player) && canDamage {global.player.hp -= damage; canDamage = false;}	
		// Set attack dist
		_attackDist = attackMoveSpd * attackDirX;
		attackDistX += abs(_attackDist);
		// Move for attack or end attack
		if attackDistX < attackDistTotal {x += _attackDist;}
		else {setInactive(); attackDistX = 0; canAttack = false;}
	}
	
	// Initialize attack
	if !active && canAttack {
		setActive(attackSpr, 600);
		canDamage = true;
		// Set attackDirX
		if global.player.x < x {attackDirX = -1;}
		else {attackDirX = 1;}
	}
	
	// Attack startup
	if !active && canAttack && (_xToPlayer <= attackRange || _yToPlayer <= attackRange) {
		setActive(attackStartSpr, startingFrames);
	}
	
	// Attacking cooldown
	if !canAttack {
		attackCooldownTimer++;
		if attackCooldownTimer >= attackCooldown {canAttack = true; attackCooldownTimer = 0;}
	}
	
	// Set x and y speeds
	xspd = moveSpd * moveDirX;
	yspd = moveSpd * moveDirY;
	
	// Move
	x += xspd;
	y += yspd;
	
	// Damage player
	//if canDamage {
	//	if place_meeting(x, y, global.player) {global.player.hp -= 1;}
	//	canDamage = false;
	//}
	
	/*---------------------------------- Sprites ----------------------------------*/
	//sprite_index = idleSpr;
	//if sleeping {sprite_index = sleepSpr;}
	//else if waking {sprite_index = wakeUpSpr;}
	//else if startingAttack {sprite_index = attackStartSpr;}
	//else if attacking {sprite_index = attackSpr;}
	//// Mask
	//mask_index = defaultMaskSpr;
	if sleeping {sprite_index = sleepSpr;}
	else if !active {sprite_index = idleSpr;}
	else {sprite_index = activeSpr;}
}