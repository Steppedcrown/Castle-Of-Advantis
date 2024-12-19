// Inherit the parent event
event_inherited();

/*---------------------------------- Misc ----------------------------------*/
// Detection
detectionRange = 100;
// Padding
xPad = 10;

/*---------------------------------- Attacking ----------------------------------*/
meleeDamage = 50;
attackObj = obj_ghostly_attack;
// Proj
proj = obj_ghostly_head;
headDamage = 50;
projSpd = 0.5;
// Melee ranges
meleeRangeX = 30;
meleeRangeY = meleeRangeX;
closeRangeX = 50;
closeRangeY = closeRangeX;
// Shooting ranges
shootRangeX = 300;
shootRangeY = shootRangeX;
// Cooldowns
attackCooldown = 60;
attackCooldownTimer = attackCooldown;
shootCooldown = 90;
shootCooldownTimer = shootCooldown;
actionCooldown = 30;
actionCooldownTimer = actionCooldown;

/*---------------------------------- States ----------------------------------*/
canAttack = false;
canShoot = false;
canAction = false;
sleeping = true;
headless = false;
closeRange = false;

/*---------------------------------- Sprites ----------------------------------*/
idleSpr = spr_ghostly_armor_idle;
idleHeadless = spr_ghostly_armor_no_head_idle;
sleepSpr = spr_ghostly_armor_unactivated;
wakingSpr = spr_ghostly_armor_activation;
walkSpr = spr_ghostly_armor_walk;
attackSpr = spr_ghostly_armor_sword_attack;
headAttackSpr = spr_ghostly_armor_head_attack;
// Animation frames
attackFrames = 18;
wakingFrames = 60;
shootingFrames = 35;