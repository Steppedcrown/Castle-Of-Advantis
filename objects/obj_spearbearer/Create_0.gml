// Inherit the parent event
event_inherited();

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_spearbearer_idle;
idleSpr = spr_spearbearer_idle;
walkSpr = spr_spearbearer_walk;
jumpSpr = spr_spearbearer_jump;
crouchSpr = spr_spearbearer_crouch;

/*---------------------------------- Head ----------------------------------*/
playerHead = instance_create_depth(x, y, PLAYER_DEPTH - 1, obj_spearbearer_head);
playerHead.defaultSpr = spr_spearbearer_head;
playerHead.idleSpr = spr_spearbearer_head_idle;
playerHead.maxAngle = 40;

jumpMax = 2;