// Find rotation
var _x;
var _y;

if mouse_x - x > 0 {_x = 1;}
else if mouse_x - x < 0 {_x = -1;}
else {_x = 0;}

if mouse_y - y > 0 {_y = -1;}
else if mouse_y - y < 0 {_y = 1;}
else {_y = 0;}

// Find quadrant
var _angle = image_angle;
if canRotate {
	switch (global.player.face) {
		// Facing right
		case 1:
			if _y == 1 {_angle = 45;} // Up
			else if _y == -1 {_angle = 315;} // Down
			else {_angle = 0;} // Forward
			break;
		// Facing left
		case -1:
			if _y == 1 {_angle = -45;} // Up
			else if _y == -1 {_angle = -315;} // Down
			else {_angle = 0;} // Forward
			break;
	}
}

// Draw sprite
draw_sprite_ext(sprite_index, global.player.image_index, x, y, image_xscale*global.player.face, image_yscale, _angle, image_blend, image_alpha);