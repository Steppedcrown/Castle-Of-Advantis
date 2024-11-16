// Inherit the parent event
event_inherited();

/*---------------------------------- Movement ----------------------------------*/
// Speeds
moveSpd = 1;
jumpSpd = 1.25;

// Directions
jumpDirX = 0;
jumpDirY = 0;

// Target coords
targetX = 0;
targetY = 0;
midpoint = 0;
// Total movement
totalX = 0;
totalY = 0;

/*---------------------------------- Combat ----------------------------------*/
// HP
maxHp = 8
hp = maxHp;

// Damage
jumpDamage = 5;
projDamage = 3;
canDamage = false;

// Ranges
detectionRange = 50;
jumpRange = 80;

// Cooldowns
jumpCooldown = 300;
jumpCooldownTimer = jumpCooldown;
shootCooldown = 180;
shootCooldownTimer = shootCooldown;

/*---------------------------------- Sprites ----------------------------------*/
idleSpr = spr_spider_idle;
walkSpr = spr_spider_walk;
jumpSpr = spr_spider_jump;
holdSpr = spr_spider_hold;
shootSpr = spr_spider_web_attack;


/*---------------------------------- Scoring ----------------------------------*/
pointValue = 20;

/*---------------------------------- Animation Frames ----------------------------------*/
holdFrames = 90;
shootFrames = 60;

/*---------------------------------- States ----------------------------------*/
canJump = false;
canShoot = false;
holding = false;
jumping = false;