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
					playTransition(rm_main, 38, 335);
					break;
				// Settings
				case 1: menu_depth++; pos = 0; break;
				// Quit game
				case 2: 
					playTransition(rm_quit);
					//game_end(); 
					break;
			}
			break;
		// Settings sub-menu
		case 1:
			switch (pos) {
				// Something
				case 0: break;	
				// Back
				case 1: menu_depth--; pos = 0; break;
			}
			break;
	}
}