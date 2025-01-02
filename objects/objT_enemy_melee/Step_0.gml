// If attack has not yet dealt damage
if canDamage {
	// Get current enemy
	var _playerHit = instance_place(x, y, objT_player);
	// If enemy exists
	if _playerHit {
		// Damage and register the hit
		_playerHit.hp -= damage;
		canDamage = false;
	}
}

// Set coords
x = parent.x + offsetX;
y = parent.y - parent.sprite_height/2 - offsetY;
// Set xscale
image_xscale = parent.face;