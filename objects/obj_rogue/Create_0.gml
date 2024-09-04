// Inherit the parent event
event_inherited();

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_rogue_idle;
idleSpr = spr_rogue_idle;
walkSpr = spr_rogue_walk;
jumpSpr = spr_rogue_jump;
crouchSpr = spr_rogue_crouch;
attackSpr = spr_rogue_attack;

/*---------------------------------- Attacking ----------------------------------*/
attackFramesCount = 15;
attackCooldownCount = 30;
attackCooldownTimer = attackCooldownCount;
attackMoveSpd = 2;

/*---------------------------------- Supering ----------------------------------*/
superFramesCount = 180;
superCooldownIncrement = 5;

/*---------------------------------- Head ----------------------------------*/
playerHead = instance_create_depth(x, y, PLAYER_DEPTH - 1, obj_rogue_head);
playerHead.defaultSpr = spr_rogue_head;
playerHead.idleSpr = spr_rogue_head_idle;
playerHead.maxAngle = 40;