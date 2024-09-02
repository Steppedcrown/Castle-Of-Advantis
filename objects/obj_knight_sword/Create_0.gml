// Inherit the parent event
event_inherited();

// Create list to store hit enemies
enemiesHitCurr = ds_list_create();
enemiesHitPrev = ds_list_create();

// Travelling stats
outgoing = true;

// Set proj stats
projSpd = 3;
projDamage = 3;

/* Gravity
affectedByGrav = true;
grav = 0.03; */