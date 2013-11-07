
float radius = 10.0;
int circleX, circleY;
int nX, nY;

void setup() {
  
  // set canvas size.
  size( 300, 300 );
  
  // set the initial position of the circle.
  circleX = width / 2;
  circleY = height / 2;
  
  // set the initial values of the stored mouse position.
  nX = circleX;
  nY = circleY;
  
}


void draw() {
  
  // the radius of the circle indicator changes with frameCount.
  radius = radius + sin( frameCount / 4 );
  
  // track circle indicator to new destination.
  circleX += (nX - circleX);
  circleY += (nY - circleY);
  
  // set the canvas background to grey.
  background( 100 );
  
  // draw a blue circle with white outline.
  fill( 0, 120, 180 );
  stroke( 255 );
  ellipse( circleX, circleY, radius, radius );
  
}


void mouseMoved() {
  
  nX = mouseX;
  nY = mouseY;
  
}
