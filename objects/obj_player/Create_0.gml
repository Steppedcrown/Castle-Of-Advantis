// Controls setup
controlsSetup();

// Movement
moveDir = 0;
moveSpd = 2;
xspd = 0;
yspd = 0;

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
