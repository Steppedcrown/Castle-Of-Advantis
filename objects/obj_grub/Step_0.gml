// Inherit the parent event
event_inherited();

if !instance_exists(obj_pauser) {
	// Set face
	face = moveDirX;
	
	// Set xspd and move
	xspd = moveDirX * moveSpd;
	if !place_meeting(x+xspd, y, obj_wall) && 
	place_meeting(x+xspd, y+1, obj_wall) && 
	!ensnared {x += xspd;}
	
	// Slopes
	if place_meeting(x+xspd, y, obj_wall) {
		var _total = 0;
		var _moved = false;
		while !place_meeting(x+moveDirX, y-3, obj_wall) && _total < abs(xspd) {
			if place_meeting(x+moveDirX, y+1, obj_wall) {x += moveDirX; _total += 1; _moved = true;}
		}
		if _moved {y -= 3;}
		else if !ensnared {swapDir = true;}
	}
	else if !place_meeting(x+xspd, y, obj_wall) && place_meeting(x+xspd, y+5, obj_wall) && !ensnared {
		x += xspd;
	}
	else {swapDir = true;}
	
	// Drop to ground
	if !place_meeting(x, y+grav, obj_wall) {y += grav;}
	
	// Swap direction if dist has been moved
	if !infMovement {currMovement += abs(xspd);}
	if currMovement >= totalMovement || swapDir {moveDirX *= -1; currMovement = 0; swapDir = false;}
	
	// Damage player
	damageTimer++;
	if damageTimer >= damageCooldown && place_meeting(x, y, objT_player) {global.player.hp -= damage; damageTimer = 0;}
	
	/*---------------------------------- Sprites ----------------------------------*/
	if xspd == 0 {sprite_index = idleSpr;}
	else {sprite_index = walkSpr;}
	mask_index = defaultMaskSpr;
}