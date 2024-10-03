// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	
	/*---------------------------------- Movement ----------------------------------*/
	// Clear x and y speeds
	xspd = 0;
	yspd = 0;
	// Find absolute distance to player
	var _xToPlayer = abs(global.player.x - x);
	var _yToPlayer = abs(global.player.y - y);
	// If player is within detection range move towards them
	if _xToPlayer <= detectionRange || _yToPlayer <= detectionRange {
		// If asleep, wake up
		if sleeping || waking {
			sleeping = false;
			waking = true;
			wakingTimer++;
			if wakingTimer > wakingCount {waking = false; wakingTimer = 0;}
		}
		// If not attacking move towards them
		else if !startingAttack && !attacking {
			// Set moveDirX
			if global.player.x < x {moveDirX = -1;}
			else if global.player.x > x {moveDirX = 1;}
			else {moveDirX = 0;}
			// Set moveDirY
			if global.player.y < y {moveDirY = -1;}
			else if global.player.y > y {moveDirY = 1;}
			else {moveDirY = 0;}
		}
	}
	
	// Set x and y speeds
	xspd = moveSpd * moveDirX;
	yspd = moveSpd * moveDirY;
	
	// Move
	x += xspd;
	y += yspd;
	
	/*---------------------------------- Sprites ----------------------------------*/
	sprite_index = idleSpr;
	if sleeping {sprite_index = sleepSpr;}
	else if waking {sprite_index = wakeUpSpr;}
	else if startingAttack {sprite_index = attackStartSpr;}
	else if attacking {sprite_index = attackSpr;}
	// Mask
	mask_index = defaultMaskSpr;
}