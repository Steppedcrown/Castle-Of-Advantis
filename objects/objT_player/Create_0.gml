/*---------------------------------- Custom functions ----------------------------------*/
function setOnGround (_val = true) {
	if _val {
		onGround = true;
		coyoteHangTimer = coyoteHangFrames;
	}
	else {
		onGround = false;
		myFloorPlat = noone;
		coyoteHangTimer = 0;
	}
}
	
function checkForSemiSolidPlatformPlayer (_x, _y) {
	// Create return variable
	var _semiSolidPlat = noone;
	
	// If not moving upwards and colliding with semi-solid
	if yspd >= 0 && place_meeting(_x, _y, obj_semi_solid_wall) {
		// Create list to store all collisions
		var _list = ds_list_create();
		var _listSize = instance_place_list(_x, _y, obj_semi_solid_wall, _list, false);
			
		// Check all found instances
		for (var i = 0; i < _listSize; i++) {
			var _listInst = _list[| i];
			if _listInst != forgetSemiSolid && floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.yspd) {
				// Set return value
				_semiSolidPlat = _listInst;
				// Exit loop early
				i = _listSize;
			}
		}
		// Destroy list
		ds_list_destroy(_list);
	}
	return _semiSolidPlat;
}


/*---------------------------------- Controls setup ----------------------------------*/
controlsSetup();

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = spr_maria_idle;
idleSpr = spr_maria_idle;
walkSpr = spr_maria_walk;
runSpr = spr_maria_run;
jumpSpr = spr_maria_jump;
crouchSpr = spr_maria_crouch;
attackSpr = noone;
superSpr = noone;
// Spearbearer only
attackUpSpr = noone;
attackDownSpr = noone;
attackSideSpr = noone;

// Other
playerHead = noone;

// Depth
depth = PLAYER_DEPTH;

/*---------------------------------- States ----------------------------------*/
dead = false;
invulnerable = false;
crouching = false;
attacking = false;
canAttack = true;
supering = false;
// Out of room
outOfRoomCount = 30;
outOfRoomTimer = 0;
// Knight only
hasSword = true;

/*---------------------------------- Attacking ----------------------------------*/
// Animation tracker
attackFramesCount = 0;
attackFramesTimer = 0;
// Spam prevention
attackCooldownCount = 0;
attackCooldownTimer = 0;
// Damage
canPenetrate = true;
canDamage = true;
damage = 1;
// Charged attacks
chargeable = false;
chargeSprFrames = 0;
attackChargeCount = 0;
attackChargeTimer = 0;
/*---------------------------------- Projectiles ----------------------------------*/
// Basic
projSpd = 0;
projDamage = 0;
// Bow charge
chargeable = false;
chargedCount = 0;
// Gravity
// Basic proj
affectedByGrav = false;
gravProj = 0;
// Super proj
affectedByGravSuper = false;
gravSuper = 0;

/*---------------------------------- Supering ----------------------------------*/
// Animation tracker
superFramesCount = 0;
superFramesTimer = 0;
// Cooldown
superCooldownIncrement = 1;
superReady = true;
// Super Stats
projSpdSuper = 0;
projDamageSuper = 0;
// Spearbearer Only
shieldDuration = 0;

/*---------------------------------- Combat ----------------------------------*/
maxHp = 50;
hp = maxHp;
// Crushing
crushDeathFrames = 3;
crushDeathTimer = 0;

/*---------------------------------- Movement ----------------------------------*/
face = 1;
moveDir = 0;
xspd = 0;
yspd = 0;
// Move speeds
runType = 0;
moveSpd[0] = 2;
moveSpd[1] = 3.5
crouchMoveSpd = moveSpd[0] / 2; // Set to 0 to disable movement while crouching
attackMoveSpd = moveSpd[0] / 2; // Set to 0 to disable movement while attacking

/*---------------------------------- Jumping ----------------------------------*/
// Basic jumping
grav = 0.4;
termVel = 4;
onGround = true;
// Advanced jumping
jumpMax = 2;
jumpCount = 0;
jumpHoldTimer = 0;
// Values for successive jumps
jumpHoldFrames[0] = 15;
jumpHoldFrames[1] = 10;
jspd[0] = -2.5;
jspd[1] = -2.9;

/*---------------------------------- Coyote time ----------------------------------*/
// Hang time
coyoteHangFrames = 5;
coyoteHangTimer = 0;
// Jump buffer time
coyoteJumpFrames = 10;
coyoteJumpTimer = 0;

/*---------------------------------- Moving platforms ----------------------------------*/
myFloorPlat = noone;
downSlopeSemiSolid = noone;
forgetSemiSolid = noone;
movePlatXspd = 0;
earlyMovePlatXspd = false;
movePlatMaxYspd = termVel; // How fast player can follow downwards moving platform