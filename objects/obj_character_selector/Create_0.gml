// Create character/head array
charArray[0, 0] = spr_knight_idle;
charArray[1, 0] = spr_archer_idle;
charArray[2, 0] = spr_mage_idle;
charArray[3, 0] = spr_rogue_idle;
charArray[4, 0] = spr_spearbearer_idle;

charArray[0, 1] = spr_knight_head_idle;
charArray[1, 1] = spr_archer_head_idle;
charArray[2, 1] = spr_mage_head_idle;
charArray[3, 1] = spr_rogue_head_idle;
charArray[4, 1] = spr_spearbearer_head_idle;

// Get array length
len = array_length(charArray);
// Set cursor position
pos = 0;

// Set head height offset
headOffset = global.player.sprite_height - global.player.playerHead.sprite_height;
// Head padding
headPad = 20;
// Head scale
headScale = 2;

// Dist from left for char windows
distLeft = 15;
// Dist from top for char windows
distTop = 25;

// Get total width
totalWidth = camera_get_view_width(view_camera[0]) / len;
// Get total height
totalHeight = camera_get_view_height(view_camera[0]);

// Width of char windows
winWidth = totalWidth - distLeft - (distLeft/len);
// Height of char windows
winHeight = totalHeight - (distTop*2);