// Go to main menu
if keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_start) {
	playTransition(rm_title_screen);
}

// Toggle fullscreen
if keyboard_check_pressed(vk_f11) {
	window_set_fullscreen(!window_get_fullscreen());
}

// Exit if there is not a player
if !instance_exists(obj_knight) {exit;}

// Get camera size
var _camWidth = camera_get_view_width(view_camera[0]);
var _camHeight = camera_get_view_height(view_camera[0]);

// Get camera target position
var _camX = obj_knight.x - _camWidth/2;
var _camY = obj_knight.y - _camHeight/2;

// Constrain to room borders
_camX = clamp(_camX, 0, room_width - _camWidth);
_camY = clamp(_camY, 0, room_height - _camHeight);

// Set cam coordinate variables
finalCamX += (_camX - finalCamX) * camTrailSpd;
finalCamY += (_camY - finalCamY) * camTrailSpd;

// Set camera coordinates
camera_set_view_pos(view_camera[0], finalCamX, finalCamY);