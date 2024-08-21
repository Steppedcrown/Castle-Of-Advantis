/*---------------------------------- Movement ----------------------------------*/
moveDirX = 0;
moveDirY = 0;
moveSpd = 1;
xspd = 0;
yspd = 0;
paddingX = 100;
paddingY = 100;

/*---------------------------------- Combat ----------------------------------*/
// Hp
maxHp = 5;
hp = maxHp;
hpX = 0;
hpY = 0;
hpRatio = 1;
hpScaleOutline = 7.3;
hpScaleBar = hpScaleOutline * 3;
hpScaleOutline += 0.7;
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
projectile = objT_enemy_projectile;
damage = 1;
projSpd = 3;
maxMoveSpd = 3;
moveSpdMargin = 0;
// Homing
homing = true;
tempHoming = true;
homingCount = attackSpd / 4;
homingLagCount = 0;