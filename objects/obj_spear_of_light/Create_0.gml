// Inherit the parent event
event_inherited();

// Lock spear to 4 directions
// Right/Left
if angle <= 45 && angle >= -45 {angle = 0; global.player.attackMoveSpd = 2;}
// Up/Down
else if angle <= 90 && angle > 45 {angle = 90; global.player.attackMoveSpd = 0;}
else {angle = -90; global.player.attackMoveSpd = 0;}

// Set new angle
image_angle = angle;