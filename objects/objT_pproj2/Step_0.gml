originY += sqr(clamp(ydist, 0, 0.75));

x += xspd;
y += -spdY + originY;

// Destroy when out of room or hitting a wall
if x < 0 || x > room_width 
|| y < 0 || y > room_height {
	destroyed = true;
}

if destroyed {instance_destroy();}