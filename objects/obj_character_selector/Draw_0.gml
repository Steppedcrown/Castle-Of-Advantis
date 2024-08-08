// Dim background
draw_sprite_tiled(spr_dim_background, image_index, 0, 0);

// Draw each character box
for (var i = 0; i < len; i++) {
	var _c = c_white;
	draw_sprite_stretched_ext(spr_char_window, image_index, distLeft*(i+1) + winWidth*i, distTop, winWidth, winHeight, _c, 1);
}