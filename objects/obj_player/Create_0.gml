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

/*---------------------------------- Sprites ----------------------------------*/
maskSpr = spr_player_idle;
idleSpr = spr_player_idle;
walkSpr = spr_player_walk;
runSpr = spr_player_run;
jumpSpr = spr_player_jump;

/*---------------------------------- Movement ----------------------------------*/
face = 1;
moveDir = 0;
xspd = 0;
yspd = 0;
// Walking and sprinting
runType = 0;
moveSpd[0] = 2;
moveSpd[1] = 3.5

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