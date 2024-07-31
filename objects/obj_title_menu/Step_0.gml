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
					if !instance_exists(obj_transition) {
						var inst = instance_create_depth(0, 0, -9999, obj_transition);
						inst.target_rm = rm_main;
						inst.target_x = 270;
						inst.target_y = 315;
						inst.moveDir = 1;
					}
					break;
				// Settings
				case 1: menu_depth++; pos = 0; break;
				// Quit game
				case 2: 
					if !instance_exists(obj_transition) {
						var inst = instance_create_depth(0, 0, -9999, obj_transition);
						inst.target_rm = rm_quit;
						inst.target_x = -999;
						inst.target_y = -999;
						inst.moveDir = 1;
					}
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