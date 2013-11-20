
float radius = 5.0;
int circleX, circleY;

int lineWidth, fillColour;
int canvasH, canvasW;

WiiRemoteJ deviceFinder;
WiiRemote remote;

ArrayList<Shape> shapes;
ArrayList<Circle> shapePoints;

ToolBar toolbar;

color[] colours;

Shape selected;

boolean control;

int xMouse, yMouse;

//////////////////////////////////////////////////////////////

void setup() {
  
  canvasW = 1000;
  canvasH = 700;
  
  //set property for bluetooth communication
  System.setProperty("bluecove.jsr82.psm_minimum_off", "true");
  
  // set canvas size.
  size( canvasW, canvasH );
  
  //canvas set to drawing mode by default
  control = false;
  
  // set the initial position of the circle.
  circleX = width / 2;
  circleY = height / 2;
  
  //set initial fill colour and line width
  fillColour = 0;
  lineWidth = 1;
  
  //do not display default cursor
  noCursor();
  
  //create empty list of shapes
  shapes = new ArrayList<Shape>();

  // create colour palette
  colours = new color[10];
  colours[0] = color(100, 0, 100);
  colours[1] = color(200);
  colours[2] = color(204, 153, 0);
  colours[3] = color(200, 0, 0);
  colours[4] = color(0, 200, 0);
  colours[5] = color(0, 0, 200);
  
  toolbar = new ToolBar(canvasW/100, canvasH/100, canvasW/6, canvasH - canvasH/50);
  
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
  try {
    remote.vibrateFor(1000); 
  } catch(IOException e) {
  }
  
  
  try {
    remote.setAccelerometerEnabled(true);
  } catch(IOException e) {
    println("IOException caught enabling accelerometer");
  }
  
  WiimoteListener wiiList = new WiimoteListener();
  remote.addWiiRemoteListener(wiiList); 
}

// View /////////////////////////////

void draw() {
  
  // the radius of the circle indicator changes with frameCount.
  radius = radius + sin( frameCount / 4 );
  
  // set the canvas background to white.
  background( 255 );
  
  // Draw Shapes
  for(Shape s : shapes) {
    s.drawShape();
  }  
  
  //set stroke colour to white
  stroke(200);
  
  // Draw toolbar. Maybe make the toolbar moveable?
  toolbar.drawToolBar();
  
  // draw a blue circle with white outline for the indicator.
  // eventually, I'd like the indicator color to match the background color of the selected tool icon.
  fill( 0, 120, 180 );
  stroke( 255 );
  strokeWeight(1);
  ellipse( circleX, circleY, radius, radius );
  
}

// Controller ///////////////////////


void mouseMoved() {
  xMouse = mouseX;
  yMouse = mouseY;
  circleX = mouseX;
  circleY = mouseY;
}

void mousePressed() {
  if(!control) {
    shapePoints = new ArrayList<Circle>();
  }
}
void mouseDragged() {
    xMouse = mouseX;
    yMouse = mouseY;
    circleX = mouseX;
    circleY = mouseY;
    
    if(!control) {
      Circle c = new Circle(mouseX, mouseY, 0);
      shapePoints.add(c);
    }
  }


void mouseReleased() {
  if(mouseY<canvasH/100) {
  }
  if(!control) {
    AbstractShape a = new AbstractShape(shapePoints, lineWidth, colours[fillColour]);
    shapes.add(a);
  }
}

void mouseClicked() {
  if(mouseY<toolbar.getHeight()) {
    toolbar.wasClicked(mouseX, mouseY);
  }
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

