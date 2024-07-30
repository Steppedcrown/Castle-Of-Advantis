// Draw each button
var _x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2 - button_width/2;
var _y = 25 + obj_title.sprite_height;
for (var i = 0; i < op_length; i++) {
	var _color = c_white;
	if i == pos {_color = c_yellow;}
	draw_sprite_ext(spr_button, image_index, _x, _y + button_space*i, 1, 1, 0, _color, 1);
}