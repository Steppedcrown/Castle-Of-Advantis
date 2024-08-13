// Get max height of parabola
vertexY = mouse_y;
projSpd = 0;

xdist = abs(x - mouse_x);
ydist = abs(y - mouse_y);
// Set Euclidean difference
dist = sqrt(sqr(xdist) + sqr(ydist));
// Standardize values
xdist /= dist;
ydist /= dist;
xspd = clamp(xdist, 0, 2);

originY = sqr(xspd) + vertexY;
spdY = vertexY + 7;

xspd = 4;

destroyed = false;