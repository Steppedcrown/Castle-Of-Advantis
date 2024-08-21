// Damage
canDamage = true;
damage = 0;

// Set angle
var _x = mouse_x - x;
var _y = mouse_y - y;
image_angle = 0;

// Find angle of player facing right
if global.player.face > 0 {image_angle = arctan2(_y, _x) * -180 / pi;}
// Else find angle of player facing left
else {image_angle = arctan2(-_y, -_x) * -180 / pi;}

// Set xscale
image_xscale *= global.player.face;