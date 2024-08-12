function centerOnX (obj=noone) {
	if obj != noone {
		with (obj) {
			x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2 - sprite_width/2;
		}
	}
	else {
		return camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2;
	}
}

function centerOnY (obj=noone) {
	if obj != noone {
		with (obj) {
			y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])/2 - sprite_height/2;
		}
	}
	else {
		return camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])/2;
	}
}
	
function isNotInPlayArea() {
	return (room == rm_init || room == rm_title_screen || room == rm_quit);
}

function checkForSemiSolidPlatform (_x, _y) {
	// Create return variable
	var _semiSolidPlat = noone;
	
	// If not moving upwards and colliding with semi-solid
	if yspd >= 0 && place_meeting(_x, _y, obj_semi_solid_wall) {
		// Create list to store all collisions
		var _list = ds_list_create();
		var _listSize = instance_place_list(_x, _y, obj_semi_solid_wall, _list, false);
			
		// Check all found instances
		for (var i = 0; i < _listSize; i++) {
			var _listInst = _list[| i];
			if floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.yspd) {
				// Set return value
				_semiSolidPlat = _listInst;
				// Exit loop early
				i = _listSize;
			}
		}
		// Destroy list
		ds_list_destroy(_list);
	}
	return _semiSolidPlat;
}

function createProj (projectile, rangeX, rangeY, damage, projSpd, maxMoveSpd, moveSpdMargin, homing, tempHoming, homingCount, homingLagCount, minSpd) {
	var _proj = instance_create_depth(x, y - sprite_height/2, -40, projectile);
	// Determine x direction
	if x < global.player.x {_proj.moveDirX = 1;}
	else if x > global.player.x {_proj.moveDirX = -1;}
	else {_proj.moveDirX = 0;}
	// Determine y direction
	if y < global.player.y {_proj.moveDirY = 1;}
	else if y > global.player.y {_proj.moveDirY = -1;}
	else {_proj.moveDirY = 0;}
	// Store initial x and y coords
	_proj.initX = x;
	_proj.initY = y;
	// Set moveSpd for x and y directions
	var _xToPlayer = abs(x - global.player.x);
	var _yToPlayer = abs(y - global.player.y);
	_proj.moveSpdX = _xToPlayer / (_yToPlayer * _xToPlayer);
	_proj.moveSpdY = _yToPlayer / (_xToPlayer * _yToPlayer);
	// Pass on range of enemy
	_proj.rangeX = rangeX;
	_proj.rangeY = rangeY;
	// Set damage and proj speeds
	_proj.damage = damage;
	_proj.projSpd = projSpd;
	_proj.maxMoveSpd = maxMoveSpd;
	_proj.moveSpdMargin = moveSpdMargin;
	// Homing settings
	_proj.homing = homing;
	_proj.tempHoming = tempHoming;
	_proj.homingCount = homingCount;
	_proj.homingLagCount = homingLagCount;
	_proj.minSpd = minSpd;
}

function playTransition (_transition=obj_transition, _rm=rm_title_screen, _x=-999, _y=-999, _spd = -1) {
	if !instance_exists(_transition) {
		var inst = instance_create_depth(0, 0, -9999, obj_transition);
		inst.target_rm = _rm;
		inst.target_x = _x;
		inst.target_y = _y;
		inst.imageSpd = _spd;
	}	
}

function controlsSetup() {
	// Set buffer frame amount for all inputs
	bufferTime = 5;
	
	// Jump buffering
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
}

function getMenuControls() {
	up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(0, gp_padu);
	down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_padd);
	left = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) || gamepad_button_check_pressed(0, gp_padl);
	right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")) || gamepad_button_check_pressed(0, gp_padr);
	select = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1);
}

function getPlayerControls() {
	/*---------------------------------- Directional Inputs ----------------------------------*/
	// Joystick
	gpDeadzone = gamepad_set_axis_deadzone(0, 0.15);
	gpJoystickLH = gamepad_axis_value(0, gp_axislh);
	gpJoystickLV = gamepad_axis_value(0, gp_axislv);
	
	// Keyboard
	rightKey = keyboard_check(ord("D"));
	leftKey = keyboard_check(ord("A"));
	upKey = keyboard_check(ord("W"));
	downKey = keyboard_check(ord("S"));
	
	// Movement
	if !(rightKey && leftKey && upKey && downKey) && gamepad_is_connected(0) {
		// Horizontal checks
		if gpJoystickLH >= gpDeadzone {rightKey += abs(gpJoystickLH);}
		else if gpJoystickLH <= gpDeadzone {leftKey =+ abs(gpJoystickLH);}
		// Vertical checks
		if gpJoystickLV <= gpDeadzone {upKey += abs(gpJoystickLV);}
		else if gpJoystickLV >= gpDeadzone {downKey += abs(gpJoystickLV);}
	}
	
	// Clamp inputs
	rightKey = clamp(rightKey, 0, 1);
	leftKey = clamp(leftKey, 0, 1);
	upKey = clamp(upKey, 0, 1);
	downKey = clamp(downKey, 0, 1);
	
	// Move cursor with joystick
	#region
	scrollSpeed = 25;
	var inputx = gamepad_axis_value(0, gp_axisrh);
	var inputy = gamepad_axis_value(0, gp_axisrv);
	var cursorx = window_mouse_get_x() + inputx * scrollSpeed;
	var cursory = window_mouse_get_y() + inputy * scrollSpeed;
	window_mouse_set( cursorx, cursory);
	#endregion
	
	/*---------------------------------- Action inputs ----------------------------------*/
	// Jumping
	jumpKeyPressed = clamp(keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1), 0, 1);
	if isNotInPlayArea() {jumpKeyPressed = 0;} // Do not read jump unless in play area
	jumpKey = clamp(keyboard_check(vk_space) || gamepad_button_check(0, gp_face1), 0, 1);
	
	// Sprinting
	runKey = clamp(keyboard_check(vk_lshift) || gamepad_button_check(0, gp_face2), 0, 1);
	
	// Attacking
	attackKeyPressed = clamp(mouse_check_button_pressed(mb_left) || gamepad_button_check_pressed(0, gp_shoulderrb), 0, 1);
	
	/*---------------------------------- Input buffering ----------------------------------*/
	// Jump buffering
	if jumpKeyPressed {
		jumpKeyBufferTimer += bufferTime;
	}
	if jumpKeyBufferTimer > 0 {
		jumpKeyBuffered = 1;
		jumpKeyBufferTimer--;
	} 
	else {jumpKeyBuffered = 0;}
}