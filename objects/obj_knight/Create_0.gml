event_inherited();

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_knight_idle;
idleSpr = spr_knight_idle;
walkSpr = spr_knight_walk;
jumpSpr = spr_knight_jump;
crouchSpr = spr_knight_crouch;
attackSpr = spr_knight_attack;

/*---------------------------------- Attacking ----------------------------------*/
attackFramesCount = 15;
attackCooldownCount = 30;
attackCooldownTimer = attackCooldownCount;
attackMoveSpd = 2;

/*---------------------------------- Supering ----------------------------------*/
superFramesCount = 20;
superCooldownIncrement = 10;

/*---------------------------------- Head ----------------------------------*/
playerHead = instance_create_depth(x, y, PLAYER_DEPTH - 1, obj_knight_head);
playerHead.defaultSpr = spr_knight_head;
playerHead.idleSpr = spr_knight_head_idle;
playerHead.maxAngle = 40;

jumpMax = 2;