// Get movement input
getPlayerControls();

/*---------------------------------- DEATH ----------------------------------*/
if hp <= 0 {
	hp = maxHp;
	global.player_deaths++;
	playTransition();
}

/*---------------------------------- X Movement ----------------------------------*/

// Get direction
moveDir = rightKey - leftKey;

// Get face
if mouse_x - x > 0 {face = 1;}
else if mouse_x - x < 0 {face = -1;}

/*
if moveDir < 0 {face = -1;}
else if moveDir > 0 {face = 1;}
*/

// Get runType
runType = 0; // set to runKey to enable sprinting

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

// Pause movement
if instance_exists(obj_pauser) {xspd = 0;}

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

/*---------------------------------- Platform/Floor Y collision ----------------------------------*/
// Check for solid and semi-solid platforms under me
var _clampYspd = max(0, yspd);
var _list = ds_list_create();
var _array = array_create(0);
array_push(_array, obj_wall, obj_semi_solid_wall);

// Do the check and store objs in _list
var _listSize = instance_place_list(x, y+1 + _clampYspd + movePlatMaxYspd, _array, _list, false);

// Iterate through each object
for (var i = 0; i < _listSize; i++) {
	// Get current instance
	var _listInst = _list[| i];
	// Avoid magnetism
	if (_listInst.yspd <= yspd || instance_exists(myFloorPlat))
	&& (_listInst.yspd > 0 || place_meeting(x, y+1 + _clampYspd, _listInst)) {
		// Return solid walls or semi-solid walls below the player
		if _listInst.object_index == obj_wall
		|| object_is_ancestor(_listInst.object_index, obj_wall)
		|| floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.yspd) {
			// Find highest platform
			if !instance_exists(myFloorPlat)
			|| _listInst.bbox_top + _listInst.yspd <= myFloorPlat.bbox_top + myFloorPlat.yspd
			|| _listInst.bbox_top + _listInst.yspd <= bbox_bottom {
				myFloorPlat = _listInst;
			}
		}
	}
}
// Destroy list to avoid memory leak
ds_list_destroy(_list);
// Make sure platform is actually below us and clear myFloorPlat if not
if instance_exists(myFloorPlat) && !place_meeting(x, y + movePlatMaxYspd, myFloorPlat) {
	myFloorPlat = noone;
}
// Land on platform
if instance_exists(myFloorPlat) {
	// Move up to wall
	_subPixel = 0.5;
	while !place_meeting(x, y + _subPixel, myFloorPlat) && !place_meeting(x, y, obj_wall) {y += _subPixel;}
	// Make sure we do not end up below the top of a semi-solid
	if myFloorPlat.object_index == obj_semi_solid_wall || object_is_ancestor(myFloorPlat.object_index, obj_semi_solid_wall) {
		while place_meeting(x, y, myFloorPlat) {y -= _subPixel;}	
	}
	// Floor y
	y = floor(y);
	// Collide with ground
	yspd = 0;
	setOnGround(true);
}

// Move Y
y += yspd;

// Final moving platforms movement and collision
// X move with platform
movePlatXspd = 0;
if instance_exists(myFloorPlat) {movePlatXspd = myFloorPlat.xspd;}
// Move with movePlatXspd
if place_meeting(x + movePlatXspd, y, obj_wall) {
	_subPixel = 0.5;
	var _pixelCheck = _subPixel * sign(movePlatXspd);
	while !place_meeting(x + _pixelCheck, y, obj_wall) {x += _pixelCheck;}
	movePlatXspd = 0;
}
// Move
x += movePlatXspd;

// Y snap to platform
if instance_exists(myFloorPlat) && (myFloorPlat.yspd != 0
|| myFloorPlat.object_index == obj_semi_solid_moving
|| object_is_ancestor(myFloorPlat.object_index, obj_semi_solid_moving)) {
	// Snap to top of floor platform
	if !place_meeting(x, myFloorPlat.bbox_top, obj_wall)
	&& myFloorPlat.bbox_top >= bbox_bottom-movePlatMaxYspd {
		y = myFloorPlat.bbox_top;
	}
	// Going up into solid wall on semi-solid platform
	if myFloorPlat.yspd < 0 && place_meeting(x, y-1, obj_wall) {
			if myFloorPlat.object_index == obj_semi_solid_moving || object_is_ancestor(myFloorPlat.object_index, obj_semi_solid_moving) {
				// Get pushed down through semi-solid
				_subPixel = 0.25;
				while place_meeting(x, y-1, obj_wall) {y += _subPixel;}
				// If player got pushed into solid wall while going down, push player back out
				while place_meeting(x, y, obj_wall) {y -= _subPixel;}
				y = round(y);
			}
			// Reset myFloorPlat
			myFloorPlat = noone;
	}
}

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

/*---------------------------------- Out of play area ----------------------------------*/
if room == rm_title_screen {
	x = -999;
	y = -999;
}