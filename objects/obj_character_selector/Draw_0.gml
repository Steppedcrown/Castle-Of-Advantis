// Dim background
draw_sprite_tiled(spr_dim_background, image_index, 0, 0);

// Draw each character box
for (var i = 0; i < len; i++) {
	var _c = c_white;
	if pos == i {_c = c_yellow;}
	var _currX = distLeft*(i+1) + winWidth*i;
	// Draw character windows
	draw_sprite_stretched_ext(spr_char_window, image_index, distLeft*(i+1) + winWidth*i, distTop, winWidth, winHeight, _c, 1);
	// Draw characters
	draw_sprite_stretched(charArray[i, 0], 0, _currX, distTop, winWidth, winHeight-1);
	// Draw heads
	draw_sprite_stretched(charArray[i, 1], 0, _currX + headPad, distTop - headOffset, winWidth/headScale, winHeight/headScale);
}