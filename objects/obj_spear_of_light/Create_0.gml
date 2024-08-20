// Damage
damage = 2;

// Set angle
var _x = mouse_x - x;
var _y = mouse_y - y;
angle = 0;

// Find angle of player facing right
if global.player.face > 0 {angle = arctan2(_y, _x) * -180 / pi;}
// Else find angle of player facing left
else {angle = arctan2(-_y, -_x) * -180 / pi;}

// Set face
face = global.player.face;