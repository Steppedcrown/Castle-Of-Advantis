// Set coords
var _x = global.player.x;
var _y = global.player.y - sprite_height/2;

// Draw the thang
draw_sprite_ext(sprite_index, image_index, _x, _y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);