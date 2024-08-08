event_inherited();

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_knight_idle;
idleSpr = spr_knight_idle;
walkSpr = spr_knight_walk;
jumpSpr = spr_knight_jump;

/*---------------------------------- Head ----------------------------------*/
playerHead = instance_create_depth(x, y, playerDepth - 1, obj_knight_head);
playerHead.defaultSpr = spr_knight_head;
playerHead.idleSpr = spr_knight_head_idle;
playerHead.maxAngle = 40;

jumpMax = 2;