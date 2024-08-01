// Hit player and destroy proj
if collision_line(x, y, x + moveDirX*moveSpd, y, player, false, true) {
	player.hp -= damage;
	instance_destroy();
}

// Move
x += moveDirX * moveSpd;

// Set Final Destination
if finalX != initX {
	finalX = initX;
	if moveDirX > 0 {finalX += rangeX;}
	else {finalX -= rangeX;}
}

// Destroy when off screen or when max range is reached
if x < 0 || x > room_width 
|| moveDirX > 0 && x >= finalX
|| moveDirX < 0 && x <= finalX {
	instance_destroy();
}