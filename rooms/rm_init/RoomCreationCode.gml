// Set player
for (var i = 0; i < instance_count; i++) {
	var _currObj = instance_find(all, i).object_index;
	if object_is_ancestor(_currObj, obj_player_template) {
		global.player = _currObj;
	}
}

//playTransition();
room_goto_next();