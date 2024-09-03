// Set padding
var _pad = 5;
// Reflect on y if proj is above or below
if other.y + _pad > y || other.y - _pad < y - sprite_height {other.moveDirY *= -1;}
// Otherwise reflect on x
else {other.moveDirX *= -1;}