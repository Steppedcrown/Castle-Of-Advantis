// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	// Set face
	face = moveDirX;
	
	// Set xspd and move
	xspd = moveDirX * moveSpd;
	x += xspd;
	
	// Swap direction if dist has been moved
	currMovement += abs(xspd);
	if currMovement >= totalMovement {moveDirX *= -1; currMovement = 0;}
}