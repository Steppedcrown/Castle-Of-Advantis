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
// Attack charge stats
chargeable = true;
chargeSprFrames = 3;
attackChargeCount = 240;

/*---------------------------------- Supering ----------------------------------*/
superFramesCount = 20;
superCooldownIncrement = 10;

/*---------------------------------- Head ----------------------------------*/
playerHead = instance_create_depth(x, y, PLAYER_DEPTH - 1, obj_archer_head);
playerHead.defaultSpr = spr_archer_head;
playerHead.idleSpr = spr_archer_head_idle;
playerHead.maxAngle = 40;