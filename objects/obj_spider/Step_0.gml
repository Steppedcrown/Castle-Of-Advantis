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
	
	/*---------------------------------- Jumping ----------------------------------*/
	// Check if player is in range
	
	// Move if not doing anything else
	if !active {
		/*---------------------------------- Face Player ----------------------------------*/
		if global.player.x < x {moveDirX = -1;}
		else if global.player.x > x {moveDirX = 1;}
		else {moveDirX = 0;}
		// Set moveDirY
		if global.player.y < y {moveDirY = -1;}
		else if global.player.y > y {moveDirY = 1;}
		else {moveDirY = 0;}
		// Set x and y speeds
		xspd = moveSpd * moveDirX;
		yspd = moveSpd * moveDirY;
		x += xspd;
		y += yspd;
	}
	/*---------------------------------- Sprite Control ----------------------------------*/
	if !active {sprite_index = idleSpr;}
	else {sprite_index = activeSpr;}
}