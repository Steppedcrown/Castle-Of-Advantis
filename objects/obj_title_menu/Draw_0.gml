// Move title out of room if there is a pauserd
if instance_exists(obj_pauser) {
	with (obj_title) {
		x = -999;
		y = -999;
	}
}
else {
	// Font settings
	draw_set_font(global.font_main);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);

	// Find center
	var _center = centerOnX();

	// Update which menu we are in
	op_length = array_length(options[menu_depth]);

	// Set button size
	var longest = string_width(options[menu_depth, 0]);
	for (var i = 1; i < op_length; i++) {
		var curr = string_width(options[menu_depth, i]);
		if curr > longest {longest = curr};
	}

	// Set variables and reset to default if smaller
	button_width = op_border*2 + longest;
	if button_width < default_button_width {button_width = default_button_width;}
	button_height = op_border*2 + string_height(options[0, 0]) + op_space;
	if button_height < default_button_height {button_height = default_button_height;}
	button_space = button_height + 10;

	// Text options
	text_space = button_height/2 + 1;

	// Set position for buttons
	var _x = _center - button_width/2;
	var _y = 25 + obj_title.sprite_height;

	// Draw each button with text
	for (var i = 0; i < op_length; i++) {
		// Change color if button is selected
		var _color = c_white;
		if i == pos {_color = c_yellow;}
		// Draw button
		var _currY = _y + button_space*i
		draw_sprite_stretched_ext(spr_button, image_index, _x, _currY, button_width, button_height, _color, 1);
		// Set current string
		var _currString = options[menu_depth][i]
		draw_text_color(_center - string_width(_currString)/2, _currY + text_space - string_height(_currString)/2, _currString, _color, _color, _color, _color, 1);
	}

	/*---------------------------------- Title ----------------------------------*/
	with (obj_title) {
		// Centered on x-axis
		centerOnX(self);
		// Pixels from top of screen
		y = 10;
		depth = 10;
	}

	/*---------------------------------- Death ----------------------------------*/
	if global.player_deaths > 0 {
		draw_text_transformed_color(40, 80, string_concat("DEATHS: ", global.player_deaths) , 3, 3, 30, c_red, c_red, c_red, c_red, 1);
	}
}