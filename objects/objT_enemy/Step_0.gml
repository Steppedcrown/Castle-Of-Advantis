if !instance_exists(obj_pauser) {
	// Track ensnare duration
	if ensnared {ensnaredTimer++;}
	// Unensnare when duration is over
	if ensnared && ensnaredTimer >= ensnaredDuration*60 {
		ensnared = false;
		ensnaredTimer = 0;
	}
	
	// Reset activity
	if active && activeFrames != -1 {
		activeCount++;
		if activeCount >= activeFrames {active = false;}
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
	
	// Set face if not on a predetermined path
	if !predeterminedPath {
		if global.player.x > x {face = -1;}
		else if global.player.x < x {face = 1;}
	}
}