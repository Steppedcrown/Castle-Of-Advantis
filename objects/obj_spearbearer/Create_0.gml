// Inherit the parent event
event_inherited();

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_spearbearer_idle;
idleSpr = spr_spearbearer_idle;
walkSpr = spr_spearbearer_walk;
jumpSpr = spr_spearbearer_jump;
crouchSpr = spr_spearbearer_crouch;
// Attack Sprs
attackUpSpr = spr_spearbearer_attack_up;
attackDownSpr = spr_spearbearer_attack_down;
attackSideSpr = spr_spearbearer_attack_leftright;

/*---------------------------------- Attacking ----------------------------------*/
attackFramesCount = 15;
attackCooldownCount = 30;
attackCooldownTimer = attackCooldownCount;
attackMoveSpd = 2;

/*---------------------------------- Supering ----------------------------------*/
superFramesCount = 20;
superCooldownIncrement = 10;
shieldDuration = 5;

/*---------------------------------- Head ----------------------------------*/
playerHead = instance_create_depth(x, y, PLAYER_DEPTH - 1, obj_spearbearer_head);
playerHead.defaultSpr = spr_spearbearer_head;
playerHead.idleSpr = spr_spearbearer_head_idle;
playerHead.maxAngle = 40;