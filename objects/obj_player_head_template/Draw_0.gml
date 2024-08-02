// Find rotation
var _x = mouse_x - x;
var _y = mouse_y - y;

// Rotate
if canRotate {
	// Find angle
	var _angle = arctan2(_y, _x) * -180 / pi;
	
	// Cap angle
	// Up and right
	if  _angle <= 90 && _angle > 45{
		_angle = 60;
	}
	// Up and left
	if _angle >= 90 && _angle < 135 {
		_angle = 120;	
	}
	// Down and right
	if _angle >= 270 && _angle < 315 {
		_angle = 315;	
	}
	// Down and left
	if _angle <= 270 && _angle > 225 {
		_angle = 225;
	}
}

// Draw sprite
draw_sprite_ext(sprite_index, global.player.image_index, x, y, image_xscale*global.player.face, image_yscale, _angle, image_blend, image_alpha);