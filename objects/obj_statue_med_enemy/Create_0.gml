// Inherit the parent event
event_inherited();

/*---------------------------------- Projectile ----------------------------------*/
// Proj
projectile = obj_statue_proj;
// Speed
projSpd = 1;
attackSpd = 90;
attackTimer = attackSpd;
// Range
rangeX = 100;
rangeY = 100;
// Dmg
damage = 50;

/*---------------------------------- States ----------------------------------*/
predeterminedPath = true;
canShoot = false;

/*---------------------------------- Spirtes ----------------------------------*/
idleSpr = spr_statue_real;
shootSpr = spr_statue_real_attack;
shootFrames = 30;