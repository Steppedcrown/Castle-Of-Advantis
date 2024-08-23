// Attack can pierce enemies
if canPenetrate {	
	// Get all enemies hit
	var _len = instance_place_list(x, y, objT_enemy, enemiesHitCurr, false);
	// Iterate through for each hit enemy
	for (var i = 0; i < _len; i++) {
		// Set current hit enemy
		var _enemyHit = enemiesHitCurr[| i];
		// If the current enemy was not previously hit
		if ds_list_find_index(enemiesHitPrev, _enemyHit) == -1 {
			// Damage it
			_enemyHit.hp -= damage;
			// Then add it to the list
			ds_list_add(enemiesHitPrev, _enemyHit);
		}
	}
}
// Attack cannot pierce enemies
else {
	// If attack has not yet dealt damage
	if canDamage {
		// Get current enemy
		var _enemyHit = instance_place(x, y, objT_enemy);
		// If enemy exists
		if _enemyHit {
			// Damage and register the hit
			_enemyHit.hp -= damage;
			canDamage = false;
		}
	}
}