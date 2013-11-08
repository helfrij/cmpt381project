
float radius = 5.0;
int circleX, circleY;

WiiRemoteJ deviceFinder;
WiiRemote remote;

void setup() {
  
  // set canvas size.
  size( 300, 300 );
  
  // set the initial position of the circle.
  circleX = width / 2;
  circleY = height / 2;
  
  // create an instance of WiiRemote
  deviceFinder = new WiiRemoteJ();
  remote = deviceFinder.findRemote();
  
}


void draw() {
  
  // the radius of the circle indicator changes with frameCount.
  radius = radius + sin( frameCount / 4 );
  
  // set the canvas background to grey.
  background( 100 );
  
  // draw a blue circle with white outline.
  fill( 0, 120, 180 );
  stroke( 255 );
  ellipse( circleX, circleY, radius, radius );
  
}


void mouseMoved() {
  
  circleX = mouseX;
  circleY = mouseY;
  
}
