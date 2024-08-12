if !instance_exists(obj_pauser) {
	// DEATH
	if hp <= 0 {instance_destroy();}
	/*---------------------------------- Movement ----------------------------------*/
	// Face player X
	if x + paddingX < global.player.x {moveDirX = 1;}
	else if x - paddingX > global.player.x {moveDirX = -1;}
	else {moveDirX = 0;}

	// Face player Y
	if y + paddingY < global.player.y {moveDirY = 1;}
	else if y - paddingY > global.player.y {moveDirY = -1;}
	else {moveDirY = 0;}

	// Set x and y spd
	xspd = moveDirX * moveSpd;
	yspd = moveDirY * moveSpd;

	// Move
	x += xspd;
	y += yspd;

	/*---------------------------------- Range ----------------------------------*/
	// Reset inRange variables
	inRangeX = false;
	inRangeY = false;

	if x + rangeX >= global.player.x 
	|| x - rangeX <= global.player.x {
		inRangeX = true;	
	}
	if y + rangeY >= global.player.y
	|| y - rangeY <= global.player.y {
		inRangeY = true;	
	}

	// Determine whether player is inRange
	inRange = inRangeX && inRangeY;

	/*---------------------------------- Attacking ----------------------------------*/
	// Increase the timer
	attackTimer += 1;

	if inRange {
		// Make sure enemy can attack
		if attackTimer >= attackSpd {
			// Check for LOS
			if collision_line(x, y - sprite_height/2, global.player.x, global.player.y - global.player.sprite_height/2, global.player, true, false) {
				// FIRE IN THE HOLE
				createProj(projectile, rangeX, rangeY, damage, projSpd, maxMoveSpd, moveSpdMargin, homing, tempHoming, homingCount, homingLagCount, minSpd);
				// Reset timer
				attackTimer = 0;
			}
		}
	}
}