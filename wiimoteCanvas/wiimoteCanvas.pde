
float radius = 5.0;
int circleX, circleY;

int lineWidth, fillColour;
float toolbarH, toolbarW;
int canvasH, canvasW;

WiiRemoteJ deviceFinder;
WiiRemote remote;

ArrayList<Shape> shapes;

ArrayList<Circle> shapePoints;

void setup() {
  
  canvasW = 1000;
  canvasH = 700;
  toolbarH = canvasH - canvasH/50;
  toolbarW = canvasW/6;
  
  System.setProperty("bluecove.jsr82.psm_minimum_off", "true");
  // set canvas size.
  size( canvasW, canvasH );
  
  // set the initial position of the circle.
  circleX = width / 2;
  circleY = height / 2;
  
  fillColour = 0;
  lineWidth = 1;
  
  noCursor();
  
  shapes = new ArrayList<Shape>();
  /*
  // create an instance of WiiRemote
  deviceFinder = new WiiRemoteJ();
  
  try
  {
    remote = deviceFinder.findRemote();
    println("Looking for wiimote...");
  } catch (InterruptedException e)
  {
    println("InterruptedException caught...");
  } catch (IOException ie)
  {
    println("IOexception caught...");
  }
  
  if(null != remote)
    println("Wiimote successfully connected!");
    
    */
}

// View /////////////////////////////

void draw() {
  
  // the radius of the circle indicator changes with frameCount.
  radius = radius + sin( frameCount / 4 );
  
  // set the canvas background to grey.
  background( 100 );
  
  // Draw Shapes
  for(Shape s : shapes) {
    s.drawShape();
  }  
  
  // Draw toolbar
  fill(0);
  strokeWeight(1);
  rect(canvasH/100, canvasH/100, toolbarW, toolbarH);
  
  // draw a blue circle with white outline.
  fill( 0, 120, 180 );
  stroke( 255 );
  ellipse( circleX, circleY, radius, radius );
  
}

// Controller ///////////////////////


void mouseMoved() {
  circleX = mouseX;
  circleY = mouseY;
}

void mousePressed() {
  shapePoints = new ArrayList<Circle>();
}
void mouseDragged() {
  circleX = mouseX;
  circleY = mouseY;
 
  Circle c = new Circle(mouseX, mouseY, 0);
  shapePoints.add(c);
}

void mouseReleased() {
  AbstractShape a = new AbstractShape(shapePoints);
  shapes.add(a);
}

void mouseClicked() {
  Circle c = new Circle(mouseX, mouseY, lineWidth);
  shapes.add(c);
}

