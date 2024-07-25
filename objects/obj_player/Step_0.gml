// Get movement input
getControls();

/*---------------------------------- X Movement ----------------------------------*/

// Get direction
moveDir = rightKey - leftKey;

// Get face
if moveDir < 0 {face = -1;}
else if moveDir > 0 {face = 1;}

// Get runType
runType = runKey;

// Get xspd
xspd = moveDir * moveSpd[runType];

// X collision
var _subPixel = 0.5;
if place_meeting(x+xspd, y, obj_wall) {
	// Check for slope (optional: multiply xspd by 2 for slopes > 45 degrees)
	if !place_meeting(x+xspd, y - abs(xspd)-1, obj_wall) {
		// Move to top of pixel
		while place_meeting(x+xspd, y, obj_wall) {y -= _subPixel;}
	}
	// Then check for ceiling slope, otherwise just do regular collision
	else {
		// Ceiling slope 
		if !place_meeting(x+xspd, y + abs(xspd)+1, obj_wall) {
			while place_meeting(x+xspd, y, obj_wall) {y += _subPixel;}
		}
		// Normal collision
		else {
			// Move right up to wall
			var _pixelCheck = _subPixel * sign(xspd);
			while !place_meeting(x+_pixelCheck, y, obj_wall) {x += _pixelCheck;}
			xspd = 0;
		}
	}
}

// Go down slopes
if yspd >= 0 && !place_meeting(x+xspd, y+1, obj_wall) && place_meeting(x+xspd, y + abs(xspd)+1, obj_wall) {
		while !place_meeting(x+xspd, y+_subPixel, obj_wall) {y += _subPixel;}
}

// Move X
x += xspd;

/*---------------------------------- Y Movement ----------------------------------*/

// Gravity + coyote time
if coyoteHangTimer > 0 {
	// Count timer down
	coyoteHangTimer--;
}
else {
	// Apply gravity
	yspd += grav;
	// No longer on the ground
	setOnGround(false);
}

// Set/Reset jump variables
if onGround {
	jumpCount = 0; 
	jumpHoldTimer = 0;
	coyoteJumpTimer = coyoteJumpFrames;
}
else {
	coyoteJumpTimer--;
	if jumpCount == 0  && coyoteJumpTimer <= 0 {jumpCount = 1;}
}

// Initialize jump
if jumpKeyBuffered && jumpCount < jumpMax {
	// Reset the buffer
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
	
	// Increment jumpCount
	jumpCount++;
	
	// Set frames
	jumpHoldTimer = jumpHoldFrames[jumpCount-1];
	
	// Player jumped and is no longer on the ground
	setOnGround(false);
	coyoteJumpTimer = 0;
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

// Upwards Y collision (with ceiling slopes)
if yspd < 0 && place_meeting(x, y+yspd, obj_wall) {
	// Jump into sloped ceilings
	var _slopeSlide = false;
	// Slide up left slope
	if moveDir == 0 && !place_meeting(x - abs(yspd)-1, y+yspd, obj_wall) {
		while place_meeting(x, y+yspd, obj_wall) {x -= 1;}
		_slopeSlide = true;
	}
	// Slide up right slope
	if moveDir == 0 && !place_meeting(x + abs(yspd)+1, y+yspd, obj_wall) {
		while place_meeting(x, y+yspd, obj_wall) {x += 1}
		_slopeSlide = true;
	}
	
	// Normal Y collision
	if !_slopeSlide {
		
		// Move right up to wall
		var _pixelCheck = _subPixel * sign(yspd);
		while !place_meeting(x, y+_pixelCheck, obj_wall) {y += _pixelCheck;}
	
		// Bonk code (optional)
		if yspd < 0 {jumpHoldTimer = 0;}
	
		yspd = 0;
	}
	
}

// Downwards Y collision
_subPixel = 0.5;
if yspd >= 0 {
	if place_meeting(x, y+yspd, obj_wall) {
	
		// Move right up to wall
		var _pixelCheck = _subPixel * sign(yspd);
		while !place_meeting(x, y+_pixelCheck, obj_wall) {y += _pixelCheck;}
		yspd = 0;
	}

	// Set onGround
	if place_meeting(x, y+1, obj_wall) {
		setOnGround(true);
	}
}

// Move Y
y += yspd;

/*---------------------------------- Sprites ----------------------------------*/
// Idle
if xspd == 0 {sprite_index = idleSpr;}
// Walking
if abs(xspd) > 0 {sprite_index = walkSpr;}
// Running
if abs(xspd) >= moveSpd[1] {sprite_index = runSpr;}
// Jumping/In air
if !onGround {sprite_index = jumpSpr;}
// Collision mask
mask_index = maskSpr;