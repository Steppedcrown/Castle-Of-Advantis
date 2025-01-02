if !instance_exists(obj_pauser) {
	if !returning {
		// Track homing duration
		if projDuration {
			projTimer++;
			if projTimer >= projDuration {destroyed = true}
		}

		// If on first frame
		if homing || startupFrame {
			// Determine x direction
			if x < global.player.x {moveDirX = 1;}
			else if x > global.player.x {moveDirX = -1;}
			else {moveDirX = 0;}
			// Determine y direction
			if y < global.player.y {moveDirY = 1;}
			else if y > global.player.y {moveDirY = -1;}
			else {moveDirY = 0;}
		
			// Set moveSpd for x and y directions
			var _xToPlayer = abs(x - global.player.x);
			var _yToPlayer = abs(y - global.player.y + targetOffset);
			var _dist = sqrt(sqr(_xToPlayer) + sqr(_yToPlayer));
			moveSpdX = _xToPlayer / _dist;
			moveSpdY = _yToPlayer / _dist;
		
			// Scale up moveSpd values
			moveSpdX *= projSpd;
			moveSpdY *= projSpd;
	
			// 0 if is not a number
			if is_nan(moveSpdX) {moveSpdX = 0;}
			if is_nan(moveSpdY) {moveSpdY = 0;}
	
			// Will no longer be on first frame
			startupFrame = false;
		}
	
		// Destroy when hitting walls
		if place_meeting(x, y, obj_wall) {destroyed = true;}

		// Hit player and destroy proj
		var _playerHit = instance_place(x, y, objT_player)
		if !destroyed && _playerHit {
			_playerHit.hp -= damage;
			destroyed = true;
		}
	
		// Hit enemies if reflected
		var _enemyHit = instance_place(x, y, objT_enemy)
		if !destroyed && friendlyFire && _enemyHit {
			_enemyHit.hp -= damage;
			destroyed = true;
		}

		// Move if not destroyed
		if !destroyed {
			// Change yspd according to grav
			if affectedByGrav {
				if moveDirY == 1 {moveSpdY += grav;}
				else {moveSpdY -= grav;}
			}
			x += moveDirX * moveSpdX;
			y += moveDirY * moveSpdY;
		}

		// Destroy when off screen or when homing count is reached
		if x < 0 || x > room_width 
		|| y < 0 || y > room_height {
			destroyed = true;
		}

		if destroyed {returning = true;}
	}
	// On the return to body
	else {
			var _parentY = parent.y - parentHeight;
			// Determine x direction
			if x < parent.x {moveDirX = 1;}
			else if x > parent.x {moveDirX = -1;}
			else {moveDirX = 0;}
			// Determine y direction
			if y < _parentY {moveDirY = 1;}
			else if y > _parentY {moveDirY = -1;}
			else {moveDirY = 0;}
		
			// Set moveSpd for x and y directions
			var _xToParent = abs(x - parent.x);
			var _yToParent = abs(y - _parentY  + targetOffset);
			var _dist = sqrt(sqr(_xToParent) + sqr(_yToParent));
			moveSpdX = _xToParent / _dist;
			moveSpdY = _yToParent / _dist;
		
			// Scale up moveSpd values
			moveSpdX *= projSpd;
			moveSpdY *= projSpd;
	
			// 0 if is not a number
			if is_nan(moveSpdX) {moveSpdX = 0;}
			if is_nan(moveSpdY) {moveSpdY = 0;}
			
			// Move back towards body
			x += moveDirX * moveSpdX;
			y += moveDirY * moveSpdY;
			
			// When within range, destroy
			if abs(x - parent.x) <= 8 && abs(y - _parentY) <= 8 {instance_destroy();}
	}
}