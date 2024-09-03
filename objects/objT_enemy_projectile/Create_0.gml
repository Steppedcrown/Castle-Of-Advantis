/*---------------------------------- Movement ----------------------------------*/
projSpd = 0;
maxMoveSpd = 0;
moveSpdMargin = 0;
// X
moveSpdX = 0;
moveDirX = 0;
initMSX = 0;
// Y
moveSpdY = 0;
moveDirY = 0;
initMSY = 0;

/*---------------------------------- Range ----------------------------------*/
initX = 0;
initY = 0;
rangeX = 0;
rangeY = 0;

/*---------------------------------- Attack ----------------------------------*/
damage = 0;
friendlyFire = false;
// Homing
homing = false;
tempHoming = false;
homingCount = 0;
homingTimer = 0;
homingLagCount = 0;
homingLagTimer = 0;
// x y array
coordinate_list = ds_list_create();

/*---------------------------------- Misc ----------------------------------*/
startupFrame = true;
destroyed = false;