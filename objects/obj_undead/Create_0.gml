// Inherit the parent event
event_inherited();

/*---------------------------------- Misc ----------------------------------*/
// Detection
detectionRange = 100;
// Padding
xPad = 10;

/*---------------------------------- Attacking ----------------------------------*/
damage = 50;
attackObj = obj_undead_swing;
attackRangeX = 10;
attackRangeY = 10;
// Animation frames
attackFrames = 18;
// States
canAttack = false;
// Cooldowns
attackCooldown = 60;
attackCooldownTimer = attackCooldown;

/*---------------------------------- Sprites ----------------------------------*/
idleSpr = spr_undead_idle;
walkSpr = spr_undead_walk;
attackSpr = spr_undead_attack;