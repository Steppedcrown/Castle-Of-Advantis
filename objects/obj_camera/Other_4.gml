// Exit if there is not a player
if !instance_exists(global.player) {exit;}

// Get camera size
var _camWidth = camera_get_view_width(view_camera[0]);
var _camHeight = camera_get_view_height(view_camera[0]);

// Get camera target coordinates
var _camX = global.player.x - _camWidth/2;
var _camY = global.player.y - _camHeight/2;

// Constrain to room borders
_camX = clamp(_camX, 0, room_width - _camWidth);
_camY = clamp(_camY, 0, room_height - _camHeight);

// Get camera position at start of room
finalCamX = _camX;
finalCamY = _camY;