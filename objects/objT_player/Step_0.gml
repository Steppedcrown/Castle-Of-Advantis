// Only run if there is not a pauser active
if !instance_exists(obj_pauser) {
	// Get player inputs
	getPlayerControls();
	
	// Collision mask default
	mask_index = defaultMaskSpr;
	
	// Warp if touching a warp block
	var _warp = instance_place(x, y, obj_warp);
	if (_warp != noone) {playTransition(_warp.transition, _warp.targetRoom, _warp.targetX, _warp.targetY, _warp.imageSpd);}
	
	// Get movement directions
	moveDir = rightKey - leftKey;

	// Get face based off mouse
	if mouse_x - x > 0 {face = 1;}
	else if mouse_x - x < 0 {face = -1;}

	// Get face based of moveDir
	//if moveDir > 0 {face = 1;}
	//else if moveDir < 0 {face = -1;}

	// Get out of solid moveplats that the player got stuck in during the begin step event
	#region
	var _rightWall = noone;
	var _leftWall = noone;
	var _bottomWall = noone;
	var _topWall = noone;
	var _list = ds_list_create();
	var _listSize = instance_place_list(x, y, obj_solid_moving, _list, false);

	// Loop through each found instance
	for (var i = 0; i < _listSize; i++) {
		// Get current inst
		var _listInst = _list[| i];
	
		// Check for walls on each side
		// Right wall
		if _listInst.bbox_left - _listInst.xspd >= bbox_right-1 {
			// Get rightmost wall
			if !instance_exists(_rightWall) || _listInst.bbox_left < _rightWall.bbox_left {_rightWall = _listInst;}
		}
		// Left wall
		if _listInst.bbox_right - _listInst.xspd <= bbox_left+1 {
			// Get leftmost wall
			if !instance_exists(_leftWall) || _listInst.bbox_right > _leftWall.bbox_right {_leftWall = _listInst;}
		}
		// Bottom wall
		if _listInst.bbox_top - _listInst.yspd >= bbox_bottom-1 {
			if !instance_exists(_bottomWall) || _listInst.bbox_top < _bottomWall.bbox_top {_bottomWall = _listInst;}
		}
		// Top wall
		if _listInst.bbox_bottom - _listInst.yspd <= bbox_top+1 {
			if !instance_exists(_topWall) || _listInst.bbox_bottom > _topWall.bbox_bottom {_topWall = _listInst;}	
		}
	}
	// Destroy list
	ds_list_destroy(_list);

	// Move out of walls
	// Right wall
	if instance_exists(_rightWall) {
		var _rightDist = bbox_right - x;
		x = _rightWall.bbox_left - _rightDist;
	}
	// Left wall
	if instance_exists(_leftWall) {
		var _leftDist = x - bbox_left;
		x = _leftWall.bbox_right + _leftDist;
	}
	// Bottom wall
	if instance_exists(_bottomWall) {
		var _bottomDist = bbox_bottom - y;
		y = _bottomWall.bbox_top - _bottomDist;
	}
	// Top wall
	if instance_exists(_topWall) {
		var _topDist = y - bbox_top;
		var _targetY = _topWall.bbox_bottom + _topDist;
	
		// Check there is not a wall in the way
		if !place_meeting(x, _targetY, obj_wall) {y = _targetY;}
	}
	#endregion

	// Don't get left behind by moving platform
	earlyMovePlatXspd = false;
	if instance_exists(myFloorPlat) && myFloorPlat.xspd != 0 && !place_meeting(x, y + movePlatMaxYspd+1, myFloorPlat) {
		// Move back onto platform if there is not a wall
		if !place_meeting(x + myFloorPlat.xspd, y, obj_wall) {
			x += myFloorPlat.xspd;
			earlyMovePlatXspd = true;
		}
	}
		
	/*---------------------------------- Attacking ----------------------------------*/
	// Initialize attack
	attackCooldownTimer++;
	if canAttack && (attackKeyPressed && attackCooldownTimer >= attackCooldownCount) || attackChargeTimer > 0 {
		// Set variables
		attacking = true;
		attackCooldownTimer = 0;
		if attackChargeTimer < attackChargeCount {attackChargeTimer++;}
		
		// Determine attack effect
		switch (global.player) {
			case obj_knight:
				instance_create_depth(x, y - sprite_height/2, depth+1, obj_knight_swing);
				break;
			case obj_archer:
				if attackKeyReleased {instance_create_depth(x, y - sprite_height/2, depth+1, obj_archer_arrow); attackChargeTimer = 0;}
				break;
			case obj_mage:
				instance_create_depth(x, y - sprite_height/2, depth+1, obj_mage_energy_ball);
				break;
			case obj_rogue:
				instance_create_depth(x, y - sprite_height/2, depth-1, obj_rogue_attack);
				break;
			case obj_spearbearer:
				// Determine correct attackSpr
				if  (playerHead.angleCappedUp && face == 1) || (playerHead.angleCappedDown && face == -1) {attackSpr = attackUpSpr; playerHead.depth = PLAYER_DEPTH + 1;}
				else if (playerHead.angleCappedUp && face == -1) || (playerHead.angleCappedDown && face == 1) {attackSpr = attackDownSpr; playerHead.depth = PLAYER_DEPTH + 1;}
				else {attackSpr = attackSideSpr;}
				// Create spear of light
				instance_create_depth(x, y - sprite_height/2, depth+1, obj_spear_of_light);
				break;
		}
		
		// Move forward
		var _attackMovement =  face * attackMoveSpd;
		if moveDir == 0 && !place_meeting(x + _attackMovement, y, obj_wall) {x += _attackMovement}
	}
	
	// Count attack frames
	if attacking {
		// Increment timer
		attackFramesTimer++;
		if (!chargeable && attackFramesTimer >= attackFramesCount) || (chargeable && attackKeyReleased) {
			// Stop attacking when target frames have been reached
			attacking = false;
			attackFramesTimer = 0;
			playerHead.depth = PLAYER_DEPTH - 1;
		}
	}
	
	/*---------------------------------- Super Attacking ----------------------------------*/
	// Initialize super attack
	if superKeyPressed && superReady {
		supering = true;
		superReady = false;
		// Determine attack effect
		switch (global.player) {
			case obj_knight:
				// Throw sword
				hasSword = false;
				canAttack = false;
				instance_create_depth(x, y - sprite_height/2, depth+1, obj_knight_sword);
				// Set new sprites
				superSpr = spr_knight_ultimate;
				idleSpr = spr_knight_idle_no_sword;
				walkSpr = spr_knight_walk_no_sword;
				jumpSpr = spr_knight_jump_no_sword;
				break;
			case obj_archer:
				break;
			case obj_mage:
				break;
			case obj_rogue:
				// Change opacity
				image_alpha = 0.5;
				playerHead.image_alpha = 0.5;
				invulnerable = true;
				break;
			case obj_spearbearer:
				break;
		}
	}
	
	// Count super frames
	if supering {
		// Increment timer
		superFramesTimer++;
		// End super depending on current character
		switch (global.player) {
			case obj_knight:
				// Stop super animation
				if superFramesTimer >= superFramesCount {superSpr = noone;}
				if hasSword {
					// Stop supering
					supering = false;
					superFramesTimer = 0;
					// Reset sprites
					idleSpr = spr_knight_idle;
					walkSpr = spr_knight_walk;
					jumpSpr = spr_knight_jump;
				}
				break;
			case obj_archer:
				break;
			case obj_mage:
				break;
			case obj_rogue:
				// Once super duration is over
				if superFramesTimer >= superFramesCount {
					// Stop supering
					supering = false;
					superFramesTimer = 0;
					// Reset opacity
					image_alpha = 1;
					playerHead.image_alpha = 1;
					invulnerable = false;
				}
				break;
			case obj_spearbearer:
				break;
		}
	}
		
	/*---------------------------------- Crouching ----------------------------------*/
	// Manually or automatically crouch
	if onGround && (downKey || place_meeting(x, y, obj_wall)) {crouching = true;}
	
	// Change collision mask
	if crouching && !attacking {mask_index = crouchSpr;}
	
	// Manually or automatically uncrouch
	if crouching && (!downKey || !onGround) {
		mask_index = defaultMaskSpr;
		// Check if uncrouching will put player in a wall
		if !place_meeting(x, y, obj_wall) {crouching = false;}
		// Coninue crouching if it will
		else {mask_index = crouchSpr;}
	}

	/*---------------------------------- DEATH ----------------------------------*/
	if hp <= 0 || dead {
		hp = maxHp;
		dead = false;
		global.player_deaths++;
		playTransition();
	}

	/*---------------------------------- X Movement ----------------------------------*/
	// Get runType
	runType = 0; // set to runKey to enable sprinting

	// Get xspd
	xspd = moveDir * moveSpd[runType];
	
	// Movement if crouching
	if crouching {xspd = moveDir * crouchMoveSpd;}
	// Movement if attacking on ground
	//if attacking && onGround {xspd = moveDir * attackMoveSpd;}

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
	downSlopeSemiSolid = noone;
	if yspd >= 0 && !place_meeting(x+xspd, y+1, obj_wall) && place_meeting(x+xspd, y + abs(xspd)+1, obj_wall) {
		downSlopeSemiSolid = checkForSemiSolidPlatformPlayer(x+xspd, y + abs(xspd)+1);
		if !instance_exists(downSlopeSemiSolid) {
			while !place_meeting(x+xspd, y+_subPixel, obj_wall) {y += _subPixel;}
		}
	}

	// Pause movement
	//if instance_exists(obj_pauser) {xspd = 0;}

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

	// Allow for jumping while holding down if on solid platform
	var _floorIsSolid = false;
	if instance_exists(myFloorPlat)
	&& (myFloorPlat.object_index == obj_wall || object_is_ancestor(myFloorPlat.object_index, obj_wall)) {_floorIsSolid = true;}

	// Initialize jump
	if jumpKeyBuffered && jumpCount < jumpMax && (!downKey || _floorIsSolid) {
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
	_list = ds_list_create();
	var _array = array_create(0);
	array_push(_array, obj_wall, obj_semi_solid_wall, obj_semi_solid_moving);

	// Do the check and store objs in _list
	_listSize = instance_place_list(x, y+1 + _clampYspd + movePlatMaxYspd, _array, _list, false);

	// High res/speed fix
	var _yCheck = y+1 + _clampYspd;
	if instance_exists(myFloorPlat) {_yCheck += max(0, myFloorPlat.yspd);}
	var _semiSolid = checkForSemiSolidPlatformPlayer(x, _yCheck);

	// Iterate through each object
	for (var i = 0; i < _listSize; i++) {
	
		// Get current instance
		var _listInst = _list[| i];
	
		// Avoid magnetism
		if ( (_listInst != forgetSemiSolid)
		&& (_listInst.yspd <= yspd || instance_exists(myFloorPlat))
		&& (_listInst.yspd > 0 || place_meeting(x, y+1 + _clampYspd, _listInst)) )
		|| (_listInst == _semiSolid) { // High speed fix
		
			// Return solid walls or semi-solid walls below the player
			if _listInst.object_index == obj_wall
			|| object_is_ancestor(_listInst.object_index, obj_wall)
			|| floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.yspd) {
			
				// Find highest platform
				if !instance_exists(myFloorPlat)
				|| (_listInst.bbox_top + _listInst.yspd <= myFloorPlat.bbox_top + myFloorPlat.yspd
				|| _listInst.bbox_top + _listInst.yspd <= bbox_bottom) {
				
					// Set myFloorPlat
					myFloorPlat = _listInst;
				}
			}
		}
	}

	// Destroy list to avoid memory leak
	ds_list_destroy(_list);

	// Set myFloorPlat to downSlopeSemiSolid if it exists
	if instance_exists(downSlopeSemiSolid) {myFloorPlat = downSlopeSemiSolid;}

	// Make sure platform is actually below us and clear myFloorPlat if not
	if instance_exists(myFloorPlat) && !place_meeting(x, y + movePlatMaxYspd, myFloorPlat) {myFloorPlat = noone;}

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

	// Manually fall through semi-solid platform
	if downKey && jumpKeyPressed {
		// Make sure we are on semi-solid
		if instance_exists(myFloorPlat)
		&& (myFloorPlat.object_index == obj_semi_solid_wall || object_is_ancestor(myFloorPlat.object_index, obj_semi_solid_wall)) {
			// Make sure we can drop below semi-solid
			_yCheck = max(1, myFloorPlat.yspd+1);
			if !place_meeting(x, y + _yCheck, obj_wall) {
				// Move below platform
				y += 1;
			
				// Inheirit downwards yspd
				yspd = _yCheck - 1;
			
				// Forget current platform
				forgetSemiSolid = myFloorPlat;
			
				// Reset myFloorPlatp
				setOnGround(false);
			
				// Reset jump buffer
				jumpKeyBuffered = 0;
				jumpKeyBufferTimer = 0;
			}
		}
	}

	// Move Y
	if !place_meeting(x, y + yspd, obj_wall) {y += yspd;}

	// Reset forgetSemiSolid
	if instance_exists(forgetSemiSolid) && !place_meeting(x, y, forgetSemiSolid) {forgetSemiSolid = noone;}

	// Final moving platforms movement and collision
	// X Movement
	// Get x move speed
	movePlatXspd = 0;
	if instance_exists(myFloorPlat) {movePlatXspd = myFloorPlat.xspd;}

	// Move x only if x has not already moved
	if !earlyMovePlatXspd {
		// Move with movePlatXspd
		if place_meeting(x + movePlatXspd, y, obj_wall) {
			_subPixel = 0.5;
			var _pixelCheck = _subPixel * sign(movePlatXspd);
			while !place_meeting(x + _pixelCheck, y, obj_wall) {x += _pixelCheck;}
			movePlatXspd = 0;
		}

		// Move
		x += movePlatXspd;
	}

	// Y Movement
	// Y snap to platform
	if instance_exists(myFloorPlat) 
	&& (myFloorPlat.yspd != 0
	|| myFloorPlat.object_index == obj_solid_moving
	|| object_is_ancestor(myFloorPlat.object_index, obj_solid_moving)
	|| myFloorPlat.object_index == obj_semi_solid_moving
	|| object_is_ancestor(myFloorPlat.object_index, obj_semi_solid_moving)) {
	
		// Snap to top of floor platform
		if !place_meeting(x, myFloorPlat.bbox_top, obj_wall)
		&& myFloorPlat.bbox_top >= bbox_bottom-movePlatMaxYspd {
			y = myFloorPlat.bbox_top;
		}
	
		/* REDUNDANT DUE TO FOLLOWING CODE BLOCK*
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
				setOnGround(false);
		}
		*/
	}

	// Get pushed down through semi-solid my moving solid MAKES ABOVE CODE REDUNDANT*
	if instance_exists(myFloorPlat)
	&& (myFloorPlat.object_index == obj_semi_solid_wall || object_is_ancestor(myFloorPlat.object_index, obj_semi_solid_wall))
	&& place_meeting(x, y, obj_wall) {
			// If player is stuck in a wall, try to push down through semi-solid
			// Don't check too far down to avoid warping through walls
			var _maxPushDist = 10;
			var _pushedDist = 0;
			var _startY = y;
			while place_meeting(x, y, obj_wall) && _pushedDist <= _maxPushDist {
				y++;
				_pushedDist++;
			}
			// Forget myFloorPlat
			myFloorPlat = noone;
		
			// Revert back to old y pos if player is still in wall
			if _pushedDist > _maxPushDist {y = _startY;}
	}

	// Crushed code
	image_blend = c_white;
	playerHead.image_blend = c_white;
	if place_meeting(x, y, obj_wall) {
		image_blend = c_red;
		playerHead.image_blend = c_red;
		crushDeathTimer++;
		if crushDeathTimer >= crushDeathFrames {dead = true; crushDeathTimer = 0;}
	} else {crushDeathTimer = 0;}
	
	// Die when out of room
	if !isNotInPlayArea() {
		if x < 0 || y < 0 || x > room_width || y > room_height {outOfRoomTimer++;}
		else {outOfRoomTimer = 0;}
		if outOfRoomTimer >= outOfRoomCount {dead = true; outOfRoomTimer = 0;}
	}

	/*---------------------------------- Sprites and Masks ----------------------------------*/
	if !attacking {
		// Idle
		if xspd == 0 {sprite_index = idleSpr;}
		// Walking
		if abs(xspd) > 0 {sprite_index = walkSpr;}
		// Running
		if abs(xspd) >= moveSpd[1] {sprite_index = runSpr;}
		// Jumping/In air
		if !onGround {sprite_index = jumpSpr;}
		// Crouching
		if crouching {sprite_index = crouchSpr;}
	}
	else {
	// Otherwise set to attack spr
		if attacking {
			sprite_index = attackSpr;
			// If it is a chargeable attack, set correct attack frame
			if chargeable {image_index = clamp(floor(attackChargeTimer / 60), 0, chargeSprFrames);}
		}
	}
	// Lastly set to superSpr
	if superSpr != noone {sprite_index = superSpr;}
	
	// Collision mask crouching
	if crouching && !attacking {mask_index = crouchSpr;}
	// Invulnerable mask
	if invulnerable {mask_index = spr_empty;}

	/*---------------------------------- Out of play area ----------------------------------*/
	if isNotInPlayArea() {
		x = -999;
		y = -999;
		sprite_index = idleSpr;
	}
}