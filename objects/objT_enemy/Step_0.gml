if !instance_exists(obj_pauser) {
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