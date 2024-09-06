// Inherit parent
event_inherited();

/*---------------------------------- Ranged Movement ----------------------------------*/
paddingX = 100;
paddingY = 100;

/*---------------------------------- Ranged Combat ----------------------------------*/
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