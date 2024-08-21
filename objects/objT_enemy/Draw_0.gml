// Draw self
draw_self();
// Draw bar
draw_sprite_ext(spr_hp_outline, image_index, hpX - 1, hpY, hpScaleOutline, 0.65, 0, c_white, 1);
draw_sprite_ext(spr_hp_bar, image_index, hpX, hpY + 1, hpRatio, 0.5, 0, c_white, 1);