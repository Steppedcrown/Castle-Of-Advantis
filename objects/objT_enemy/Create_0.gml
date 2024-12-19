/*---------------------------------- Movement ----------------------------------*/
moveDirX = 0;
moveDirY = 0;
face = 1;
moveSpd = 1;
xspd = 0;
yspd = 0;
grav = 2;

/*---------------------------------- HP Bar ----------------------------------*/
maxHp = 5;
hp = maxHp;
hpX = 0;
hpY = 0;
hpRatio = 1;
hpScaleOutline = 7.3;
hpScaleBar = hpScaleOutline * 3;
hpScaleOutline += 0.7;

/*---------------------------------- Sprites ----------------------------------*/
defaultMaskSpr = noone;
idleSpr = noone;
walkSpr = noone;
attackSpr = noone;

/*---------------------------------- Scoring ----------------------------------*/
pointValue = 0;

/*---------------------------------- States ----------------------------------*/
// Ensnare
ensnared = false;
ensnaredDuration = 0;
ensnaredTimer = 0;
// Activity
activeSpr = noone;
active = false;
activeCount = 0;
activeFrames = 0;
// Misc
detected = false;
predeterminedPath = false;