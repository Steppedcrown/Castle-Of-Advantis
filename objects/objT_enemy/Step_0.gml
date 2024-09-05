if !instance_exists(obj_pauser) {
	// Track ensnare duration
	if ensnared {ensnaredTimer++;}
	// Unensnare when duration is over
	if ensnared && ensnaredTimer >= ensnaredDuration*60 {
		ensnared = false;
		ensnaredTimer = 0;
	}
	
	// DEATH
	if hp <= 0 {global.player_score += pointValue*10; instance_destroy();}
	
	// Set hp bar variables
	// Set coords
	hpX = x - sprite_width/2 - 3;
	hpY = y - sprite_height - 6;
	// Set hp ratio
	hpRatio = hp / maxHp;
	hpRatio *= hpScaleBar;
}