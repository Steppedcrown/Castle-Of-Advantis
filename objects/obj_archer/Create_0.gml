// Inherit the parent event
event_inherited();

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_archer_idle;
idleSpr = spr_archer_idle;
walkSpr = spr_archer_walk;
jumpSpr = spr_archer_jump;

/*---------------------------------- Head ----------------------------------*/
playerHead = instance_create_depth(x, y, playerDepth - 1, obj_archer_head);
playerHead.defaultSpr = spr_archer_head_idle;
playerHead.idleSpr = spr_archer_head_idle;
playerHead.maxAngle = 40;

jumpMax = 2;