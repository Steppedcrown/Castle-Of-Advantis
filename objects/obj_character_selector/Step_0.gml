// Get user inputs
getMenuControls();

// Set pos and loop if needed
pos += right-left;
if pos > len-1 {pos = 0;}
else if pos < 0 {pos = len-1;}

// If selected
if select {
	// Destroy player
	for (var i = 0; i < instance_count; i++) {
		var _currObj = instance_find(all, i).object_index;
		if object_is_ancestor(_currObj, objT_player) {
			instance_destroy(_currObj);
			break;
		}
	}
	switch (pos) {
		// Knight
		case 0:	global.player = obj_knight; instance_create_depth(-999, -999, -30, obj_knight); break;
		// Archer
		case 1:	global.player = obj_archer; instance_create_depth(-999, -999, -30, obj_archer); break;
		// Mage
		case 2:	global.player = obj_mage; instance_create_depth(-999, -999, -30, obj_mage); break;
		// Rogue
		case 3:	global.player = obj_rogue; instance_create_depth(-999, -999, -30, obj_rogue); break;
		// Spearbearer
		case 4:	global.player = obj_spearbearer; instance_create_depth(-999, -999, -30, obj_spearbearer); break;
	}
	playTransition();
	instance_destroy();
}