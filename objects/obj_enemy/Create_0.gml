/*---------------------------------- Player ----------------------------------*/
player = obj_knight;

/*---------------------------------- Movement ----------------------------------*/
moveDirX = 0;
moveDirY = 0;
moveSpd = 1;
xspd = 0;
yspd = 0;
paddingX = 100
paddingY = 0;

/*---------------------------------- Combat ----------------------------------*/
inRangeX = false;
inRangeY = false;
inRange = false;
rangeX = paddingX * 2;
rangeY = paddingY * 2;
attackSpd = 90;
attackTimer = attackSpd;
damage = 1;