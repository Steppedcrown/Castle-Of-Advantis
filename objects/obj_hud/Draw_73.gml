// Ensure player is in correct room with no pauser present
if !isNotInPlayArea() && !instance_exists(obj_pauser) {
	/*---------------------------------- Draw HP Bar ----------------------------------*/
	var _x = camX + 10;
	var _y = camY + 9;
	draw_sprite_ext(spr_hp_outline, image_index, _x -1, _y, 33.7, 1, 0, c_white, 1);
	draw_sprite_ext(spr_hp_bar, image_index, _x, _y + 1, hpPercent * 99, 1, 0, c_white, 1);
	
	/*---------------------------------- Write Score ----------------------------------*/
	// Font settings
	draw_set_font(global.font_main);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	// Set coords
	var _pad = 10;
	_x = camX + camera_get_view_width(view_camera[0]) - string_width(scoreboard) - _pad;
	_y = camY + _pad;
	// Draw text
	draw_text_transformed(_x, _y, scoreboard, 2, 2, 0);
}