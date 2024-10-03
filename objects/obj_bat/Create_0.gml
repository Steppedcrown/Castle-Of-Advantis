// Inherit the parent event
event_inherited();

/*---------------------------------- Movement ----------------------------------*/
moveDirX = 0;
moveDirY = 0;
face = 1;
moveSpd = 1;
xspd = 0;
yspd = 0;

/*---------------------------------- Combat ----------------------------------*/
detectionRange = 20;
attackRange = 50;
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
sleeping = true;
waking = false;
wakingCount = 30;
wakingTimer = 0;
startingAttack = false;
attacking = false;

/*---------------------------------- Scoring ----------------------------------*/
pointValue = 50;