// Inherit the parent event
event_inherited();

/*---------------------------------- Movement ----------------------------------*/
moveSpd = 1.25;
attackMoveSpd = 3;

attackDirX = 0;
attackDistX = 0;
attackDistTotal = 100;

/*---------------------------------- Combat ----------------------------------*/
// Hp
maxHp = 8;
hp = maxHp;

// Attacking
detectionRange = 100;
attackCooldown = 120;
attackCooldownTimer = attackCooldown;
attackRange = 30;

// Damaging
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
wakingFrames = 30;
wakingTimer = 0;
// Attack
canAttack = false;
startingAttack = false;
startingFrames = 30;
startingTimer = 0;
attacking = false;

/*---------------------------------- Scoring ----------------------------------*/
pointValue = 20;