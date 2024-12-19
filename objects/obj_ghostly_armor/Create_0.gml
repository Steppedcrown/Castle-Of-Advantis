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
projSpd = 2;
// Melee ranges
meleeRangeX = 10;
meleeRangeY = 30;
// Shooting ranges
shootRangeX = 100;
shootRangeY = 20;
// Cooldowns
attackCooldown = 60;
attackCooldownTimer = attackCooldown;
shootCooldown = 30;
shootCooldownTimer = shootCooldown;
actionCooldown = 30;
actionCooldownTimer = actionCooldown;

/*---------------------------------- States ----------------------------------*/
canAttack = false;
canShoot = false;
canAction = false;
sleeping = true;
headless = false;

/*---------------------------------- Sprites ----------------------------------*/
idleSpr = spr_ghostly_armor_idle;
sleepSpr = spr_ghostly_armor_unactivated;
wakingSpr = spr_ghostly_armor_activation;
walkSpr = spr_ghostly_armor_walk;
attackSpr = spr_ghostly_armor_sword_attack;
headAttackSpr = spr_ghostly_armor_head_attack;
// Animation frames
attackFrames = 18;
wakingFrames = 60;
shootingFrames = 30;