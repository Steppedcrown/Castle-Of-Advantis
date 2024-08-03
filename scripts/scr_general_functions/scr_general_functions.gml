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

function createProj (projectile, rangeX, rangeY, damage, projSpd, maxMoveSpd, moveSpdMargin, homing, tempHoming, homingCount) {
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
}

function playTransition (_rm=rm_title_screen, _x=-999, _y=-999, _dir=1, _spd = -1) {
	if !instance_exists(obj_transition) {
		var inst = instance_create_depth(0, 0, -9999, obj_transition);
		inst.target_rm = _rm;
		inst.target_x = _x;
		inst.target_y = _y;
		inst.moveDir = _dir;
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
	select = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1);
}

function getPlayerControls() {
	/*---------------------------------- Directional Inputs ----------------------------------*/
	// Joystick
	gpDeadzone = gamepad_set_axis_deadzone(0, 0.15);
	gpJoystick = gamepad_axis_value(0, gp_axislh);
	
	// Keyboard
	rightKey = keyboard_check(ord("D"));
	leftKey = keyboard_check(ord("A"));
	
	if !(rightKey && leftKey) {
		if gpJoystick >= gpDeadzone {rightKey += gpJoystick;}
		else if gpJoystick <= gpDeadzone {leftKey =+ abs(gpJoystick);}
	}
	rightKey = clamp(rightKey, 0, 1);
	leftKey = clamp(leftKey, 0, 1);
	
	/*---------------------------------- Action inputs ----------------------------------*/
	// Jumping
	jumpKeyPressed = clamp(keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1), 0, 1);
	jumpKey = clamp(keyboard_check(vk_space) || gamepad_button_check(0, gp_face1), 0, 1);
	
	// Sprinting
	runKey = clamp(keyboard_check(vk_lshift) || gamepad_button_check(0, gp_face2), 0, 1);
	
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