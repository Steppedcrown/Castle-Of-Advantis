timer++;
if timer >= duration {instance_destroy();}

var _numHit = instance_place_list(x, y, objT_enemy, enemiesHit, false);
for (var i = 0; i < _numHit; i++) {
	enemiesHit[| i].ensnared = true;
	enemiesHit[| i].ensnaredDuration = global.player.ensnaredDuration;
}