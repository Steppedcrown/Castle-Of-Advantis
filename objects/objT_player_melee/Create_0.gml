// Create list to store hit enemies
enemiesHitCurr = ds_list_create();
enemiesHitPrev = ds_list_create();

// Damage
canPenetrate = global.player.canPenetrate;
canDamage = global.player.canDamage;
damage = global.player.damage;

// Set angle
var _x = mouse_x - x;
var _y = mouse_y - y;
angle = 0;

// Find angle of player facing right
if global.player.face > 0 {angle = arctan2(_y, _x) * -180 / pi;}
// Else find angle of player facing left
else {angle = arctan2(-_y, -_x) * -180 / pi;}
image_angle = angle;

// Set xscale
image_xscale *= global.player.face;