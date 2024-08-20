// Damage enemies on hit
var _enemyHit = instance_place(x, y, objT_enemy)
if canDamage && _enemyHit {
	_enemyHit.hp -= damage;
	canDamage = false;
}