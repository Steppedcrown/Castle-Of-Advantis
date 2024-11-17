// Inherit the parent event
event_inherited();

// Misc
predeterminedPath = true;

/*---------------------------------- Movement ----------------------------------*/
moveSpd = 0.4;
grav = 1;
moveDirX = 1;
infMovement = true;
totalMovement = 75;
currMovement = 0;
swapDir = false;

/*---------------------------------- Damage ----------------------------------*/
damage = 1;
damageCooldown = 90;
damageTimer = 0;

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_grub_idle;
idleSpr = spr_grub_idle;
walkSpr = spr_grub_walk;

// Drop to ground
while !place_meeting(x, y+1, obj_wall) {y += 1;}

// Score
pointValue = maxHp;