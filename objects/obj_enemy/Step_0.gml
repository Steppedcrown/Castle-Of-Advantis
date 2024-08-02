/*---------------------------------- Movement ----------------------------------*/
// Face player X
if x + paddingX < global.player.x {moveDirX = 1;}
else if x - paddingX > global.player.x {moveDirX = -1;}
else {moveDirX = 0;}

// Face player Y
if y + paddingY < global.player.y {moveDirY = 1;}
else if y - paddingY > global.player.y {moveDirY = -1;}
else {moveDirY = 0;}

// Set x and y spd
xspd = moveDirX * moveSpd;
yspd = moveDirY * moveSpd;

// Move
x += xspd;
y += yspd;

/*---------------------------------- Range ----------------------------------*/
// Reset inRange variables
inRangeX = false;
inRangeY = false;

if x + rangeX >= global.player.x 
|| x - rangeX <= global.player.x {
	inRangeX = true;	
}
if y + rangeY >= global.player.y
|| y - rangeY <= global.player.y {
	inRangeY = true;	
}

// Determine whether player is inRange
inRange = inRangeX && inRangeY;

/*---------------------------------- Attacking ----------------------------------*/
// Increase the timer
attackTimer += 1;

if inRange {
	// Make sure enemy can attack
	if attackTimer >= attackSpd {
		// Check for LOS
		if collision_line(x, y - sprite_height/2, global.player.x, global.player.y - global.player.sprite_height/2, global.player, true, false) {
			// FIRE IN THE HOLE
			var _proj = instance_create_depth(x, y - sprite_height/2, -40, obj_projectile);
			// Determine x direction
			if x < global.player.x {_proj.moveDirX = 1;}
			else if x > global.player.x {_proj.moveDirX = -1;}
			else {_proj.moveDirX = 0;}
			// Determine y direction
			if y < global.player.y {_proj.moveDirY = 1;}
			else if y > global.player.y {_proj.moveDirY = -1;}
			else {_proj.moveDirY = 0;}
			// Store initial x and y coords
			_proj.initX = x;
			_proj.initY = y;
			// Set moveSpd for x and y directions
			//var _distToPlayer = distance_to_object(global.player);
			var _xToPlayer = abs(x - global.player.x);
			var _yToPlayer = abs(y - global.player.y);
			_proj.moveSpdX = _xToPlayer / _yToPlayer;
			_proj.moveSpdY = _yToPlayer / _xToPlayer;
			// Pass on range of enemy
			_proj.rangeX = rangeX;
			_proj.rangeY = rangeY;
			// Set damage
			_proj.damage = damage;
			// Reset timer
			attackTimer = 0;
		}
	}
}