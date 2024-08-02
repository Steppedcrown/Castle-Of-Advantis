/*---------------------------------- Position ----------------------------------*/
x = global.player.x;
y = global.player.y - global.player.sprite_height + sprite_height;

/*---------------------------------- Sprites ----------------------------------*/
// Idle
if global.player.xspd == 0 {sprite_index = idleSpr;}
else {sprite_index = defaultSpr;}