/*---------------------------------- Custom functions ----------------------------------*/
function setOnGround (_val = true) {
	if _val {
		onGround = true;
		coyoteHangTimer = coyoteHangFrames;
	}
	else {
		onGround = false;
		myFloorPlat = noone;
		coyoteHangTimer = 0;
	}
}

depth = -30;

/*---------------------------------- Controls setup ----------------------------------*/
controlsSetup();

/*---------------------------------- Sprites ----------------------------------*/
maskSpr = spr_knight_idle;
idleSpr = spr_knight_idle;
walkSpr = spr_knight_walk;
runSpr = spr_player_run;
jumpSpr = spr_knight_jump;

/*---------------------------------- Combat ----------------------------------*/
maxHp = 1;
hp = maxHp;

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
jumpMax = 1;
jumpCount = 0;
jumpHoldTimer = 0;
// Values for successive jumps
jumpHoldFrames[0] = 15;
jumpHoldFrames[1] = 10;
jspd[0] = -2.5;
jspd[1] = -2.9;

/*---------------------------------- Coyote time ----------------------------------*/
// Hang time
coyoteHangFrames = 5;
coyoteHangTimer = 0;
// Jump buffer time
coyoteJumpFrames = 10;
coyoteJumpTimer = 0;

/*---------------------------------- Moving platforms ----------------------------------*/
myFloorPlat = noone;
movePlatXspd = 0;
movePlatMaxYspd = termVel; // How fast player can follow downwards moving platform