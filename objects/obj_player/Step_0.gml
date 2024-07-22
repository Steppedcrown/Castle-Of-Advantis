// Get movement input
rightKey = keyboard_check(ord("D")) || keyboard_check(vk_right);
LeftKey = keyboard_check(ord("A")) || keyboard_check(vk_left);
jumpKeyPressed = keyboard_check_pressed(vk_space);

/* X Movement */

// Update direction and speed
moveDir = rightKey - LeftKey;
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

/* Y Movement */

// Gravity
yspd += grav;
if yspd > termVel {yspd = termVel;};

// Jump
if jumpKeyPressed && place_meeting(x, y+1, obj_wall) {
	yspd = jspd;
}

// Y collision
_subPixel = 0.5;
if place_meeting(x, y+yspd, obj_wall) {
	
	// Move right up to wall
	var _pixelCheck = _subPixel * sign(yspd);
	while !place_meeting(x, y+_pixelCheck, obj_wall) {
		y += _pixelCheck;
	}
	yspd = 0;
}

// Move Y
y += yspd;