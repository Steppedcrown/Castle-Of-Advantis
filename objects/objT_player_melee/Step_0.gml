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