// Inherit the parent event
event_inherited();

/*---------------------------------- Misc ----------------------------------*/
// Detection
detectionRange = 100;
// Padding
xPad = 10;

/*---------------------------------- Attacking ----------------------------------*/
damage = 50;
attackObj = obj_ghostly_attack;
attackRangeX = 10;
attackRangeY = 30;
// Cooldowns
attackCooldown = 60;
attackCooldownTimer = attackCooldown;

/*---------------------------------- States ----------------------------------*/
canAttack = false;
sleeping = true;

/*---------------------------------- Sprites ----------------------------------*/
idleSpr = spr_ghostly_armor_idle;
sleepSpr = spr_ghostly_armor_unactivated;
wakingSpr = spr_ghostly_armor_activation;
walkSpr = spr_ghostly_armor_walk;
attackSpr = spr_ghostly_armor_sword_attack;
// Animation frames
attackFrames = 18;
wakingFrames = 60;