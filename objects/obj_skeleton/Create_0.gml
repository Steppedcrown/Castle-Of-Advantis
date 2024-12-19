// Inherit the parent event
event_inherited();

/*---------------------------------- Misc ----------------------------------*/
// Detection
detectionRange = 100;
// Padding
xPad = 10;

/*---------------------------------- Attacking ----------------------------------*/
damage = 50;
attackObj = obj_skeleton_thrust;
attackRangeX = 20;
attackRangeY = 15;
// Animation frames
attackFrames = 18;
// States
canAttack = false;
// Cooldowns
attackCooldown = 60;
attackCooldownTimer = attackCooldown;

/*---------------------------------- Sprites ----------------------------------*/
idleSpr = spr_skeleton_idle;
walkSpr = spr_skeleton_walk;
attackSpr = spr_skeleton_attack;