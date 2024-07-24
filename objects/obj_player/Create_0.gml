/*---------------------------------- Custom functions ----------------------------------*/
function setOnGround (_val = true) {
	if _val {
		onGround = true;
		coyoteHangTimer = coyoteHangFrames;
	}
	else {
		onGround = false;
		coyoteHangTimer = 0;
	}
}

/*---------------------------------- Controls setup ----------------------------------*/
controlsSetup();

/*---------------------------------- Movement ----------------------------------*/
moveDir = 0;
moveSpd = 2;
xspd = 0;
yspd = 0;

/*---------------------------------- Jumping ----------------------------------*/
// Basic jumping
grav = 0.4;
termVel = 4;
onGround = true;
// Advanced jumping
jumpMax = 2;
jumpCount = 0;
jumpHoldTimer = 0;
// Values for successive jumps
jumpHoldFrames[0] = 10;
jumpHoldFrames[1] = 6;
jspd[0] = -3.25;
jspd[1] = -2.9;

/*---------------------------------- Coyote time ----------------------------------*/
// Hang time
coyoteHangFrames = 5;
coyoteHangTimer = 0;
// Jump buffer time
coyoteJumpFrames = 10;
coyoteJumpTimer = 0;