/*---------------------------------- Movement ----------------------------------*/
// Face player X
if x + paddingX < player.x {moveDirX = 1;}
else if x - paddingX > player.x {moveDirX = -1;}
else {moveDirX = 0;}

// Face player Y
if y + paddingY < player.y {moveDirY = 1;}
else if y - paddingY > player.y {moveDirY = -1;}
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

if x + rangeX >= player.x 
|| x - rangeX <= player.x {
	inRangeX = true;	
}
if y + rangeY >= player.y
|| y - rangeY <= player.y {
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
		if collision_line(x, y - sprite_height/2, player.x, player.y - player.sprite_height/2, player, true, false) {
			// FIRE IN THE HOLE
			var _proj = instance_create_depth(x, y - sprite_height/2, -40, obj_projectile);
			// Determine x direction
			if x < player.x {_proj.moveDirX = 1;}
			else if x > player.x {_proj.moveDirX = -1;}
			else {_proj.moveDirX = 0;}
			// Determine y direction
			if y < player.y {_proj.moveDirY = 1;}
			else if y > player.y {_proj.moveDirY = -1;}
			else {_proj.moveDirY = 0;}
			// Store initial x and y coords
			_proj.initX = x;
			_proj.initY = y;
			// Pass on range of enemy
			_proj.rangeX = rangeX;
			_proj.rangeY = rangeY;
			// Set damage and player
			_proj.damage = damage;
			_proj.player = player;
			// Reset timer
			attackTimer = 0;
		}
	}
}