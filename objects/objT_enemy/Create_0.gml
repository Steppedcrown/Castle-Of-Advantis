/*---------------------------------- Movement ----------------------------------*/
moveDirX = 0;
moveDirY = 0;
moveSpd = 1;
xspd = 0;
yspd = 0;
paddingX = 100;
paddingY = 100;

/*---------------------------------- Combat ----------------------------------*/
// Range
inRangeX = false;
inRangeY = false;
inRange = false;
rangeX = paddingX * 2;
rangeY = paddingY * 2;
// Attack speed
attackSpd = 90;
attackTimer = attackSpd;
// Projectile
projectile = objT_projectile;
damage = 1;
projSpd = 1;
maxMoveSpd = 3;
moveSpdMargin = 0;
// Homing
homing = true;
tempHoming = true;
minSpd = 75; // 100 to disable
homingCount = attackSpd / 2;
homingLagCount = 15;