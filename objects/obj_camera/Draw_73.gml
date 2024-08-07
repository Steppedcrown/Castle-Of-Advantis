// Ensure player is in correct room with no pauser present
if room != rm_init && room != rm_title_screen && room != rm_quit && !instance_exists(obj_pauser) {
	// Draw health bar
	_x = finalCamX + 10;
	_y = finalCamY + 9;
	var _hpPercent = global.player.hp / global.player.maxHp;
	draw_sprite_ext(spr_hp_outline, image_index, _x -1, _y, 33.7, 1, 0, c_white, 1);
	draw_sprite_ext(spr_hp_bar, image_index, _x, _y + 1, _hpPercent * 99, 1, 0, c_white, 1);
}