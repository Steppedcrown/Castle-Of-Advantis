// If on first frame
if startupFrame {
	// Set default move speeds
	if moveSpdX = 0 {moveSpdY = 3;}
	if moveSpdY = 0 {moveSpdX = 3;}

	// Cap move speeds
	if moveSpdX > 5 {moveSpdX = 5;}
	if moveSpdY > 5 {moveSpdY = 5;}
	
	// Scale values
	if moveSpdX < 3 {moveSpdX *= 1.25;}
	if moveSpdY < 3 {moveSpdY *= 1.25;}
	
	if moveSpdX <= 2 {moveSpdX *= 1.5;}
	if moveSpdY <= 2 {moveSpdY *= 1.5;}
	
	if moveSpdX <= 1 {moveSpdX *= 2;}
	if moveSpdY <= 1 {moveSpdY *= 2;}
	
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

/*
// Set Final Destination x
if finalX == noone {
	finalX = initX;
	if moveDirX > 0 {finalX += rangeX;}
	else if moveDirX < 0 {finalX -= rangeX;}
}

// Set Final Destination y
if finalY == noone {
	finalY = initY;
	if moveDirY > 0 {finalY += rangeY;}
	else if moveDirY < 0 {finalY -= rangeY;}
}
*/

// Destroy when off screen
if x < 0 || x > room_width 
|| y < 0 || y > room_height {
	instance_destroy();
}