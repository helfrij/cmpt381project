
float radius = 5.0;
int circleX, circleY;

int lineWidth, fillColour;
float toolbarH, toolbarW;
int canvasH, canvasW;

WiiRemoteJ deviceFinder;
WiiRemote remote;

ArrayList<Shape> shapes;
ArrayList<Circle> shapePoints;

color[] colours;

Shape selected;

boolean control;

//////////////////////////////////////////////////////////////

void setup() {
  
  canvasW = 1000;
  canvasH = 700;
  toolbarH = canvasH - canvasH/50;
  toolbarW = canvasW/6;
  
  System.setProperty("bluecove.jsr82.psm_minimum_off", "true");
  // set canvas size.
  size( canvasW, canvasH );
  
  control = false;
  
  // set the initial position of the circle.
  circleX = width / 2;
  circleY = height / 2;
  
  fillColour = 0;
  lineWidth = 1;
  
  noCursor();
  
  shapes = new ArrayList<Shape>();

  colours = new color[10];
  colours[0] = color(100, 0, 100);
  colours[1] = color(200);
  colours[2] = color(204, 153, 0);
  colours[3] = color(200, 0, 0);
  colours[4] = color(0, 200, 0);
  colours[5] = color(0, 0, 200);
  
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
  stroke(200);
  
  // Draw toolbar
  fill(0);
  strokeWeight(1);
  rect(canvasH/100, canvasH/100, toolbarW, toolbarH);
  
  /*
  fill(colours[fillColour]);
  stroke(200);
  rect(canvasH/50, canvasH/50, toolbarW*.75, toolbarH/20);
  */
  
  strokeWeight(lineWidth);
  stroke(colours[fillColour]);
  line(canvasH/50, canvasH/10, toolbarW, canvasH/10);
  
  
  // draw a blue circle with white outline.
  fill( 0, 120, 180 );
  stroke( 255 );
  strokeWeight(1);
  ellipse( circleX, circleY, radius, radius );
  
}

// Controller ///////////////////////


void mouseMoved() {
  circleX = mouseX;
  circleY = mouseY;
}

void mousePressed() {
  if(!control) {
    shapePoints = new ArrayList<Circle>();
  }
}
void mouseDragged() {
  if(!control) {
    circleX = mouseX;
    circleY = mouseY;
 
    Circle c = new Circle(mouseX, mouseY, 0);
    shapePoints.add(c);
  }
}

void mouseReleased() {
  if(!control) {
    AbstractShape a = new AbstractShape(shapePoints, lineWidth, colours[fillColour]);
    shapes.add(a);
  }
}

void mouseClicked() {
  if(control) {
    if(null != selected) {
      selected.setSelected();
    }
    selected = null;
    for(Shape s : shapes) {
      if(s.checkHit(mouseX, mouseY)) {
        s.setSelected();
        selected = s;
      }
    }
  }
  else if(!control){
    Circle c = new Circle(mouseX, mouseY, lineWidth);
    shapes.add(c);
  }
}

void keyPressed() {
  if(CODED == key) {
    if(SHIFT == keyCode) {
      control = !control;
    }
  }
  else {
    if(('a' == key) && (lineWidth<=20)) {
      lineWidth++;
    }
    else if(('s' == key) && (lineWidth>0)) {
      lineWidth--;
    }
    else if(('c' == key) && (fillColour<5)) {
      fillColour++;
    }
    else if(('c' == key) && (5==fillColour)) {
      fillColour = 0;
    }
    else if(('v' == key) && (fillColour>0)) {
      fillColour--;
    }
    else if(('v' == key) && (0 == fillColour)) {
      fillColour = 5;
    }
  }
}

