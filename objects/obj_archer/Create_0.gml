// Inherit the parent event
event_inherited();

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_archer_idle;
idleSpr = spr_archer_idle;
walkSpr = spr_archer_walk;
jumpSpr = spr_archer_jump;
crouchSpr = spr_archer_crouch;
attackSpr = spr_archer_attack;

/*---------------------------------- Attacking ----------------------------------*/
attackFramesCount = 15;
attackCooldownCount = 20;
attackCooldownTimer = attackCooldownCount;
attackMoveSpd = 0;
// Set proj stats
projSpd = 3;
projDamage = 1;
// Gravity
affectedByGrav = true;
gravProj = 0.03;
// Attack charge stats
chargeable = true;
chargeSprFrames = 3;
attackChargeCount = 240;

/*---------------------------------- Supering ----------------------------------*/
superFramesCount = 30;
superCooldownIncrement = 10;
// Proj stats
projSpdSuper = 4;
projDamageSuper = 2;
ensnaredDuration = 3;
// Gravity
affectedByGravSuper = true;
gravSuper = 0.02;

/*---------------------------------- Head ----------------------------------*/
playerHead = instance_create_depth(x, y, PLAYER_DEPTH - 1, obj_archer_head);
playerHead.defaultSpr = spr_archer_head;
playerHead.idleSpr = spr_archer_head_idle;
playerHead.maxAngle = 40;