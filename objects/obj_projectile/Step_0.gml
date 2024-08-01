// Hit player and destroy proj
if collision_line(x, y, x + moveDirX*moveSpd, y, player, true, false) {
	player.hp -= damage;
	instance_destroy();
}

// Move
x += moveDirX * moveSpd;
y += moveDirY * moveSpd;

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

// Destroy when off screen or when max range is reached
if x < 0 || x > room_width 
|| moveDirX > 0 && x >= finalX
|| moveDirX < 0 && x <= finalX
|| y < 0 || y > room_height 
//|| moveDirY > 0 && y >= finalY && moveDirY != 0
//|| moveDirY < 0 && y <= finalY && moveDirY != 0
{
	instance_destroy();
}