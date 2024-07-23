// Get movement input
getControls();

/*---------------------------------- X Movement ----------------------------------*/

// Update direction and speed
moveDir = rightKey - leftKey;
xspd = moveDir * moveSpd;

// X collision
var _subPixel = 0.5;
if place_meeting(x+xspd, y, obj_wall) {
	
	// Move right up to wall
	var _pixelCheck = _subPixel * sign(xspd);
	while !place_meeting(x+_pixelCheck, y, obj_wall) {
		x += _pixelCheck;
	}
	xspd = 0;
}

// Move X
x += xspd;

/*---------------------------------- Y Movement ----------------------------------*/

// Gravity
yspd += grav;

// Set/Reset jump variables
if onGround {jumpCount = 0; jumpHoldTimer = 0;}
else if jumpCount == 0 {jumpCount = 1;}

// Initialize jump
if jumpKeyBuffered && jumpCount < jumpMax {
	// Reset the buffer
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
	
	// Increment jumpCount
	jumpCount++;
	
	// Set frames
	jumpHoldTimer = jumpHoldFrames[jumpCount-1];
}

// Jump based on timer
if jumpHoldTimer > 0 {
	// Continuously jump
	yspd = jspd[jumpCount-1];
	// Count down
	jumpHoldTimer--;
}

// Stop jump on release
if !jumpKey {jumpHoldTimer = 0;}

// Cap falling speed
if yspd > termVel {yspd = termVel;};

// Y collision
_subPixel = 0.5;
if place_meeting(x, y+yspd, obj_wall) {
	
	// Move right up to wall
	var _pixelCheck = _subPixel * sign(yspd);
	while !place_meeting(x, y+_pixelCheck, obj_wall) {y += _pixelCheck;}
	
	// Bonk code (optional)
	if yspd < 0 {jumpHoldTimer = 0;}
	
	yspd = 0;
}

// Set onGround
if yspd >= 0 && place_meeting(x, y+1, obj_wall) {onGround = true;}
else {onGround = false;}

// Move Y
y += yspd;