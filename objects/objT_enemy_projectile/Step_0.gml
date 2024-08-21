if !instance_exists(obj_pauser) {
	// Set initial move speeds
	if startupFrame {initMSX = moveSpdX; initMSY = moveSpdY;}

	// Log players x, y coords if projectile is homing
	if homing {
		// Remove old coords
		if homingLagTimer == homingLagCount {
			ds_list_delete(coordinate_list, 0);	
			ds_list_delete(coordinate_list, 0);
		}
		// Add new coords
		ds_list_add(coordinate_list, global.player.x);
		ds_list_add(coordinate_list, global.player.y - global.player.sprite_height/2);
	}

	// If on first frame or projectile homes
	if startupFrame || homing {
		// Reset homing if it is only temporary
		if tempHoming && homing && homingTimer >= homingCount {
			homing = false;
		}
		// Set moveSpds if homing and not on first frame
		if !startupFrame && homing && homingLagTimer == homingLagCount {
			// Find delayed player coordinates
			var _lagX = coordinate_list[| 0];
			var _lagY = coordinate_list[| 1];
			// Determine move speeds
			var _xToPlayer = abs(x - _lagX);
			var _yToPlayer = abs(y - _lagY);
			var _dist = sqrt(sqr(_xToPlayer) + sqr(_yToPlayer));
			moveSpdX = _xToPlayer / _dist;
			moveSpdY = _yToPlayer / _dist;
		
			// Determine x direction
			if x < global.player.x {moveDirX = 1;}
			else if x > global.player.x {moveDirX = -1;}
			else {moveDirX = 0;}
		
			// Determine y direction
			if y < global.player.y - global.player.sprite_height/2 {moveDirY = 1;}
			else if y > global.player.y - global.player.sprite_height/2 {moveDirY = -1;}
			else {moveDirY = 0;}
		}
	
		// Scale values if proj is still homing/on first frame, otherwise keep previous values
		if startupFrame || homing {
			moveSpdX *= projSpd;
			moveSpdY *= projSpd;
		}
	
		// 0 if is not a number
		if is_nan(moveSpdX) {moveSpdX = 0;}
		if is_nan(moveSpdY) {moveSpdY = 0;}
	
		// Will no longer be on first frame
		startupFrame = false;
	}

	// Hit player and destroy proj
	if collision_line(x, y, x + moveDirX*moveSpdX, y, global.player, true, false) {
		global.player.hp -= damage;
		destroyed = true;
	}

	// Move
	x += moveDirX * moveSpdX;
	y += moveDirY * moveSpdY;

	// Destroy when off screen or when homing count is reached
	if x < 0 || x > room_width 
	|| y < 0 || y > room_height
	|| homingTimer >= homingCount && !tempHoming {
		destroyed = true;
	}

	// Increment homing timers
	homingTimer++;
	if homingLagTimer < homingLagCount {
		homingLagTimer++;
	}

	if destroyed {
		ds_list_destroy(coordinate_list);
		coordinate_list = undefined;
		instance_destroy();
	}
}