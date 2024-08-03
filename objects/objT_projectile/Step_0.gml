// Set initial move speeds
if startupFrame {initMSX = moveSpdX; initMSY = moveSpdY;}
// If on first frame or projectile homes
if startupFrame || homing {
	// Reset homing if it is only temporary
	if tempHoming && homing && homingTimer >= homingCount {
		homing = false;
		moveSpdX = initMSX;
		moveSpdY = initMSY;
	}
	// Set moveSpds if homing and not on first frame
	if !startupFrame && homing {
		// Determine move speeds
		var _xToPlayer = abs(x - global.player.x);
		var _yToPlayer = abs(y - global.player.y);
		moveSpdX = _xToPlayer / (_yToPlayer * _xToPlayer);
		moveSpdY = _yToPlayer / (_xToPlayer * _yToPlayer);
		
		// Determine x direction
		if x < global.player.x {moveDirX = 1;}
		else if x > global.player.x {moveDirX = -1;}
		else {moveDirX = 0;}
		
		// Determine y direction
		if y < global.player.y {moveDirY = 1;}
		else if y > global.player.y {moveDirY = -1;}
		else {moveDirY = 0;}
	}
	
	// Scale values
	moveSpdX *= projSpd * 100;
	moveSpdY *= projSpd * 100;
	
	// 0 if is not a number
	if is_nan(moveSpdX) {moveSpdX = 0;}
	if is_nan(moveSpdY) {moveSpdY = 0;}
	
	// Set horizontal and vertical max speeds
	if moveSpdX == 0 {moveSpdY = maxMoveSpd;}
	if moveSpdY == 0 {moveSpdX = maxMoveSpd;}
	
	// Cap move speeds
	var _count = 0;
	var _modifier = 0.5;
	while moveSpdX > maxMoveSpd+moveSpdMargin && _count < 2 {moveSpdX *= _modifier; moveSpdY *= _modifier;}
	while moveSpdY > maxMoveSpd+moveSpdMargin && _count < 2 {moveSpdX *= _modifier; moveSpdY *= _modifier;}
	
	// Will no longer be on first frame
	startupFrame = false;
}

// Hit player and destroy proj
if collision_line(x, y, x + moveDirX*moveSpdX, y, global.player, true, false) {
	global.player.hp -= damage;
	instance_destroy();
}

// Move
x += moveDirX * moveSpdX;
y += moveDirY * moveSpdY;

// Destroy when off screen or when homing count is reached
if x < 0 || x > room_width 
|| y < 0 || y > room_height
|| homingTimer >= homingCount && !tempHoming {
	instance_destroy();
}

// Increment homing count
homingTimer++;