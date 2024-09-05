// Set padding
var _pad = 5;
// Reflect on y if proj is above or below
if other.y + _pad > bbox_bottom || other.y - _pad < bbox_top {other.moveDirY *= -1;}
// Otherwise reflect on x
else {other.moveDirX *= -1;}

// Destroy proj if inside shield
if (other.y <= bbox_top && other.y >= bbox_bottom) &&
(other.x <= bbox_right && other.x >= bbox_left) {
	instance_destroy(other);
}

// Enable friendly fire
other.friendlyFire = true;
other.damage *= 1.5;