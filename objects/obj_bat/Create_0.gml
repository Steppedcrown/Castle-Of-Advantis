// Inherit the parent event
event_inherited();

/*---------------------------------- Movement ----------------------------------*/
moveDirX = 0;
moveDirY = 0;
face = 1;
moveSpd = 1.25;
xspd = 0;
yspd = 0;

/*---------------------------------- Combat ----------------------------------*/
maxHp = 8;
hp = maxHp;

detectionRange = 150;
attackCooldown = 120;
attackCooldownTimer = 0;

attackRange = 30;
attackMoveSpd = 3;

attackDirX = 0;
attackDistX = 0;
attackDistTotal = 100;

canDamage = true;
damage = 3;

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_bat_idle;
idleSpr = spr_bat_idle;
attackStartSpr = spr_bat_attack_start;
attackSpr = spr_bat_attack;
sleepSpr = spr_bat_sleeping;
wakeUpSpr = spr_bat_waking_up;

/*---------------------------------- States ----------------------------------*/
// Sleep/Wake
sleeping = true;
waking = false;
wakingCount = 30;
wakingTimer = 0;
// Attack
canAttack = true;
startingAttack = false;
startingCount = 30;
startingTimer = 0;
attacking = false;

/*---------------------------------- Scoring ----------------------------------*/
pointValue = 20;