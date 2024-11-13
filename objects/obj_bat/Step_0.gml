// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	// Find absolute distance to player
	var _xToPlayer = abs(global.player.x - x);
	var _yToPlayer = abs(global.player.y - y);
	
	// Clear move directions
	moveDirX = 0;
	moveDirY = 0;
	
	// If player is within detection range or bat is awake
	if (_xToPlayer <= detectionRange && _yToPlayer <= detectionRange) || !sleeping {
		if !active {
			// Either wake up
			if sleeping {
				setActive(wakeUpSpr, wakingFrames);
				sleeping = false;
			}
			// Or set moveDirs towards player
			else {
				// Set moveDirX
				if global.player.x < x - xPad {moveDirX = -1;}
				else if global.player.x > x + xPad {moveDirX = 1;}
				else {moveDirX = 0;}
				// Set moveDirY
				if global.player.y - yPad < y {moveDirY = -1;}
				else {moveDirY = 1;}
			}
		}
		
		// Attack
		if active && activeSpr == attackSpr {
			if place_meeting(x, y, global.player) && canDamage {global.player.hp -= damage; canDamage = false;}
			// Dive towards player
			if attackDist >= 0 {
				attackDist += targetSpdY;
				x += targetSpdX;
				y += targetSpdY;
			}
			// Stop diving
			if attackDist >= attackDistTotal {targetSpdY *= -1;}
			// Once returned, stop the attack
			if attackDist < 0 {setInactive(); attackDist = 0; canAttack = false;}
			
			
			//// Set attack dist
			//_attackDistX = attackMoveSpd * attackDirX;
			//attackDistX += abs(_attackDistX);
			//// Move for attack or end attack
			//if attackDistX < attackDistTotal {x += _attackDistX;}
			//else {setInactive(); attackDistX = 0; canAttack = false;}
		}

		// Initialize attack
		if !active && canAttack {
			setActive(attackSpr, 6969);
			canDamage = true;
			// Set moveSpd for x and y directions
			targetSpdX = abs(x - targetX);
			targetSpdY = abs(y - targetY);
			var _dist = sqrt(sqr(targetSpdX) + sqr(targetSpdY));
			targetSpdX = (targetSpdX / _dist) * attackMoveSpd;
			targetSpdY = (targetSpdY / _dist) * attackMoveSpd;
			// Set attackDirX
			if global.player.x < x {attackDirX = -1;}
			else {attackDirX = 1;}
			attackMoveSpd = abs(attackMoveSpd) * attackDirX;
		}
	
		// Attack startup
		if !active && canAttack && (_xToPlayer <= attackRange || _yToPlayer <= attackRange) {
			setActive(attackStartSpr, startingFrames);
		}
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
	
	/*---------------------------------- Sprites ----------------------------------*/
	if sleeping {sprite_index = sleepSpr;}
	else if !active || _xToPlayer > detectionRange || _yToPlayer > detectionRange {sprite_index = idleSpr;}
	else {sprite_index = activeSpr;}
}