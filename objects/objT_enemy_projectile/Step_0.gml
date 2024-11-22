if !instance_exists(obj_pauser) {

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

	// Move
	x += moveDirX * moveSpdX;
	y += moveDirY * moveSpdY;

	// Destroy when off screen or when homing count is reached
	if x < 0 || x > room_width 
	|| y < 0 || y > room_height {
		destroyed = true;
	}

	if destroyed {instance_destroy();}
}