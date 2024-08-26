// Get cam coordinates
camX = camera_get_view_x(view_camera[0]);
camY = camera_get_view_y(view_camera[0]);

// Set hp ratio
hpPercent = global.player.hp / global.player.maxHp;

// Set scoreboard
scoreboard = string(global.player_score);