// Inherit the parent event
event_inherited();

/*---------------------------------- Movement ----------------------------------*/
// Speeds
moveSpd = 1;

/*---------------------------------- Combat ----------------------------------*/
maxHp = 8
hp = maxHp;

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
holdFrames = 30;
shootFrames = 30;

/*---------------------------------- States ----------------------------------*/
canJump = false;
canShoot = false;