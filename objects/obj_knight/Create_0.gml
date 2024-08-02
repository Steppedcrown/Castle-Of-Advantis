event_inherited();

/*---------------------------------- Head ----------------------------------*/
playerHead = instance_create_depth(x, y, playerDepth, obj_knight_head);
playerHead.defaultSpr = spr_knight_head;
playerHead.idleSpr = spr_knight_head_idle;