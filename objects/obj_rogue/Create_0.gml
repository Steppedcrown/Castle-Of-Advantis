// Inherit the parent event
event_inherited();

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_rogue_idle;
idleSpr = spr_rogue_idle;
walkSpr = spr_rogue_walk;
jumpSpr = spr_rogue_jump;
crouchSpr = spr_rogue_crouch;

/*---------------------------------- Head ----------------------------------*/
playerHead = instance_create_depth(x, y, playerDepth - 1, obj_rogue_head);
playerHead.defaultSpr = spr_rogue_head_idle;
playerHead.idleSpr = spr_rogue_head_idle;
playerHead.maxAngle = 40;

jumpMax = 2;