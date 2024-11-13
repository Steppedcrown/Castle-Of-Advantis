// Inherit the parent event
event_inherited();

/*---------------------------------- Movement ----------------------------------*/
// Move Speeds
moveSpd = 1;
attackMoveSpd = 3;

// Attacking Movement
attackDirX = 0;
attackDistX = 0;
attackDistTotal = 100;

// Padding
xPad = 15;
yPad = 15;

/*---------------------------------- Combat ----------------------------------*/
// Hp
maxHp = 8;
hp = maxHp;

// Attacking
detectionRange = 150;
attackCooldown = 120;
attackCooldownTimer = attackCooldown;
attackRange = 30;

// Damaging
canDamage = true;
damage = 3;

/*---------------------------------- Sprites ----------------------------------*/
idleSpr = spr_bat_idle;
attackStartSpr = spr_bat_attack_start;
attackSpr = spr_bat_attack;
sleepSpr = spr_bat_sleeping;
wakeUpSpr = spr_bat_waking_up;

/*---------------------------------- States ----------------------------------*/
// Sleep/Wake
sleeping = true;
wakingFrames = 30;
// Attack
canAttack = false;
startingFrames = 30;

/*---------------------------------- Scoring ----------------------------------*/
pointValue = 20;