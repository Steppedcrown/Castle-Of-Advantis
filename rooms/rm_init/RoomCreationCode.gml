// Set player
for (var i = 0; i < instance_count; i++) {
	var _currObj = instance_find(all, i).object_index;
	if object_is_ancestor(_currObj, objT_player) {
		global.player = _currObj;
	}
}

room_goto_next();