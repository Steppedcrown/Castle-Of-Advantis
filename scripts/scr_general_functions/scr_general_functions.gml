function controlsSetup() {
	// Set buffer frame amount for all inputs
	bufferTime = 5;
	
	// Jump buffering
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
}

function getControls() {
	// Directional Inputs
	gpDeadzone = gamepad_set_axis_deadzone(0, 0.15);
	gpJoystick = gamepad_axis_value(0, gp_axislh);
	
	rightKey = keyboard_check(ord("D"));
	leftKey = keyboard_check(ord("A"));
	
	if !(rightKey && leftKey) {
		if gpJoystick >= gpDeadzone {rightKey += gpJoystick;}
		else if gpJoystick <= gpDeadzone {leftKey =+ abs(gpJoystick);}
	}
	rightKey = clamp(rightKey, 0, 1);
	leftKey = clamp(leftKey, 0, 1);
	
	// Action inputs
	jumpKeyPressed = clamp(keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1), 0, 1);
	jumpKey = clamp(keyboard_check(vk_space) || gamepad_button_check(0, gp_face1), 0, 1);
	
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