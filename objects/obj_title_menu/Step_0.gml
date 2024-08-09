if !instance_exists(obj_pauser) {
	// Get inputs
	getMenuControls();

	// Get size of current menu
	op_length = array_length(options[menu_depth]);
	// Move through menu
	pos += down - up;
	if pos < 0 {pos = op_length-1;}
	else if pos >= op_length {pos = 0;}

	if select {
		// Decide which menu/sub-menu you are in
		switch (menu_depth) {
			// Title menu
			case 0:
				switch (pos) {
					// Start game
					case 0: 
						playTransition(,rm_level00, 38, 335);
						break;
					// Character select
					case 1:
						charSelector = instance_create_depth(0, 0, -999, obj_character_selector);
						break;
					// Settings
					case 2: menu_depth++; pos = 0; break;
					// Quit game
					case 3: 
						playTransition(,rm_quit);
						break;
				}
				break;
			// Settings sub-menu
			case 1:
				switch (pos) {
					// Fullscreen
					case 0: 
						// Toggle fullscreen
						window_set_fullscreen(!window_get_fullscreen());
						if window_get_fullscreen() {options[1, 0] = "Fullscreen: Enabled";}
						else {options[1, 0] = "Fullscreen: Disabled";}
						// Set cursor in center (just in case it would otherwise get locked out of window)
						var _cursorX = centerOnX();
						var _cursorY = centerOnY();
						window_mouse_set( _cursorX, _cursorY);
						break;	
					// Back
					case 1: menu_depth--; pos = 0; break;
				}
				break;
		}
	}
}