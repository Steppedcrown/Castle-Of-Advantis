/*---------------------------------- Movement ----------------------------------*/
// Reset inRange variables
inRangeX = false;
inRangeY = false;

// Face player X
if x + paddingX < player.x {moveDirX = 1;}
else if x - paddingX > player.x {moveDirX = -1;}
else {moveDirX = 0; inRangeX = true;}

// Face player Y
if y + paddingY < player.y {moveDirY = 1;}
else if y - paddingY > player.y {moveDirY = -1;}
else {moveDirY = 0; inRangeY = true;}

// Set x and y spd
xspd = moveDirX * moveSpd;
yspd = moveDirY * moveSpd;

// Move
x += xspd;
y += yspd;

/*---------------------------------- Attacking ----------------------------------*/
// Increase the timer
attackTimer += 1;
// Determine whether player is inRange
inRange = inRangeX && inRangeY;
if inRange {
	// Make sure enemy can attack
	if attackTimer >= attackSpd {
		// Check for LOS
		if collision_line(x, y - sprite_height/2, x + rangeX, y - sprite_height/2, player, false, true) 
		|| collision_line(x, y - sprite_height/2, x - rangeX, y - sprite_height/2, player, false, true){
			// FIRE IN THE HOLE
			var _proj = instance_create_depth(x, y - sprite_height/2, -40, obj_projectile);
			if x < player.x {_proj.moveDirX = 1;}
			else {_proj.moveDirX = -1;}
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