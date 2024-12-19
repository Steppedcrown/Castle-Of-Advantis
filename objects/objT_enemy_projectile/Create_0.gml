/*---------------------------------- Movement ----------------------------------*/
projSpd = 0;
// X
moveSpdX = 0;
moveDirX = 0;
// Y
moveSpdY = 0;
moveDirY = 0;

/*---------------------------------- Range ----------------------------------*/
initX = 0;
initY = 0;
rangeX = 0;
rangeY = 0;

/*---------------------------------- Attack ----------------------------------*/
damage = 0;
friendlyFire = false;
targetOffset = 10;
homing = false;
projDuration = noone;
projTimer = 0;

/*---------------------------------- Misc ----------------------------------*/
startupFrame = true;
destroyed = false;
affectedByGrav = false;
grav = 0.02;