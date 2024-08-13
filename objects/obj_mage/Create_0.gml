// Inherit the parent event
event_inherited();

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_mage_idle;
idleSpr = spr_mage_idle;
walkSpr = spr_mage_walk;
jumpSpr = spr_mage_jump;
crouchSpr = spr_mage_crouch;
attackSpr = spr_mage_attack;

/*---------------------------------- Attacking ----------------------------------*/
attackFramesCount = 15;
attackCooldownCount = 30;
attackCooldownTimer = attackCooldownCount;
attackMoveSpd = 0.25;

/*---------------------------------- Head ----------------------------------*/
playerHead = instance_create_depth(x, y, PLAYER_DEPTH - 1, obj_mage_head);
playerHead.defaultSpr = spr_mage_head;
playerHead.idleSpr = spr_mage_head_idle;
playerHead.maxAngle = 40;

jumpMax = 2;