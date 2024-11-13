// Get cam coordinates
camX = camera_get_view_x(view_camera[0]);
camY = camera_get_view_y(view_camera[0]);

// Set hp ratio
hpPercent = global.player.hp / global.player.maxHp;

// Set scoreboard
scoreboard = string(global.player_score);

/*---------------------------------- Super button ----------------------------------*/
// Set super sprite
switch (global.player) {
	case obj_knight:
		spr_super_button = spr_knight_ultimate_attack_button;
		break;
	case obj_archer:
		spr_super_button = spr_archer_ultimate_attack_button;
		break;
	case obj_mage:
		spr_super_button = spr_mage_ultimate_attack_button;
		break;
	case obj_rogue:
		spr_super_button = spr_rogue_ultimate_attack_button;
		break;
	case obj_spearbearer:
		spr_super_button = spr_spearbearer_ultimate_attack_button;
		break;
}

// Get player super status
superReady = global.player.superReady;
superCooldownIncrement = global.player.superCooldownIncrement;
// Super cooldown
if !superReady && !global.player.supering {
	superCooldownTimer += superCooldownIncrement;
	if superCooldownTimer >= superCooldown {
		superReady = true;
		superCooldownTimer = 0;
	}
}

// Set the frame
superCooldownFrame = floor(superCooldownTimer / 60);
// Allow for super activation
if superReady {
	global.player.superReady = true;
	superCooldownFrame = 8;
}