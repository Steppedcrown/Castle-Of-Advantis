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
// Animation frames
attackFrames = 18;
// States
canAttack = false;
// Cooldowns
attackCooldown = 60;
attackCooldownTimer = attackCooldown;

/*---------------------------------- Sprites ----------------------------------*/
idleSpr = spr_ghostly_armor_idle;
walkSpr = spr_ghostly_armor_walk;
attackSpr = spr_ghostly_armor_sword_attack;