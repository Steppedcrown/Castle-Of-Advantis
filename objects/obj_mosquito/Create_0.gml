// Inherit the parent event
event_inherited();

// Stats
maxHp = 10;
hp = maxHp;
damage = 2;

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
projectile = obj_mosquito_proj;
damage = 1;
projSpd = 3;

// Score
pointValue = maxHp;

// Sprites
idleSpr = spr_mosquito_idle;
attackSpr = spr_mosquito_attack;