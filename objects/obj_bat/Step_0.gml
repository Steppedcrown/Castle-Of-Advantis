// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	// Find absolute distance to player
	var _xToPlayer = abs(global.player.x - x);
	var _yToPlayer = abs(global.player.y - y);
	
	// Clear move directions
	moveDirX = 0;
	moveDirY = 0;
	
	// Check if player is detected
	if !detected && _xToPlayer <= detectionRange && _yToPlayer <= detectionRange {
		detected = true;
	}	
	
	// If player is within detection range or bat is awake
	if (_xToPlayer <= detectionRange && _yToPlayer <= detectionRange) || !sleeping {
		if !active {
			// Either wake up
			if sleeping {
				setActive(wakeUpSpr, wakingFrames);
				sleeping = false;
			}
			// Or set moveDirs towards player
			else if !ensnared {
				// Set moveDirX
				if global.player.x < x - xPad {moveDirX = -1;}
				else if global.player.x > x + xPad {moveDirX = 1;}
				else {moveDirX = 0;}
				// Set moveDirY
				if global.player.y - yPad < y {moveDirY = -1;}
				else {moveDirY = 1;}
			}
		}
		if !ensnared {
			// Attack
			if active && activeSpr == attackSpr {
				if place_meeting(x, y, global.player) && canDamage {global.player.hp -= damage; canDamage = false;}
				// Dive towards player
				if attackDist >= 0 {
					if diving {attackDist += abs(targetSpdY);}
					else {attackDist -= abs(targetSpdY);}
					x += targetSpdX * attackDirX;
					y += targetSpdY / 1.1;
				}
				// Stop diving
				if attackDist >= attackDistTotal {targetSpdY *= -1; diving = false; image_angle *= -1;}
				// Once returned, stop the attack
				if attackDist < 0 {
					setInactive(); 
					attackDist = 0; 
					canAttack = false;
					image_angle = 0;
				}
			}

			// Initialize attack
			if !active && canAttack {
				setActive(attackSpr, 6969);
				canDamage = true;
				diving = true;
				// Set moveSpd for x and y directions
				targetSpdX = abs(x - global.player.x);
				targetSpdY = abs(y - global.player.y);
				var _dist = sqrt(sqr(targetSpdX) + sqr(targetSpdY));
				targetSpdX = (targetSpdX / _dist) * attackMoveSpd;
				targetSpdY = (targetSpdY / _dist) * attackMoveSpd;
				// Set x and y for angle
				var _x = global.player.x - x;
				var _y = global.player.y - y;
				// Set angle depending on direction
				if x < global.player.x {image_angle = arctan2(_y, _x) * -180 / pi;}
				else {image_angle = arctan2(-_y, -_x) * -180 / pi;}
				// Set attackDirX
				if global.player.x < x {attackDirX = -1;}
				else {attackDirX = 1;}
			}
	
			// Attack startup
			if !active && canAttack && _xToPlayer <= attackRange && _yToPlayer <= attackRange {
				setActive(attackStartSpr, startingFrames);
			}
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
	
	// Move if not ensnared
	if !ensnared {
		x += xspd;
		y += yspd;
	}
	
	/*---------------------------------- Sprites ----------------------------------*/
	if sleeping {sprite_index = sleepSpr;}
	else if !active || _xToPlayer > detectionRange || _yToPlayer > detectionRange {sprite_index = idleSpr;}
	else {sprite_index = activeSpr;}
}