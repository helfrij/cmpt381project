import de.voidplus.dollar.*;

private float cursorRadius;
private int cursorX, cursorY;
private color cursorColor;

private int canvasH, canvasW;
private color canvasColor;
private boolean crazyOn;

private WiiRemoteJ deviceFinder;
private WiiRemote remote;
//private WiimoteListener deviceListener;

private CanvasModel model;

private OneDollar recognizer;
private boolean recognized;
private boolean checkConvert;

private AbstractShape drawingShape;

//////////////////////////////////////////////////////////////

void setup() {
  cursorRadius = 5.0;
  drawingShape = null;
  
  // set canvas dimensions.
  canvasW = 1000;
  canvasH = 700;
  
  // set canvas size.
  size(canvasW, canvasH);
  
  // set the initial position of the cursor.
  cursorX = width / 2;
  cursorY = height / 2;
  
  // do not display default cursor
  noCursor();
  
  // create instance of wiiremote
//  deviceFinder = new WiiRemoteJ();
// remote = new WiiRemote();
  
  // set up wiimote listener
//  deviceListener = new WiimoteListener();
  
  // set up the model, stores the shapes drawn on the canvas and toolbars.
  model = new CanvasModel(canvasW, canvasH);
  
  canvasColor = color(220);
    
  // set up the shape recognizer.
  recognizer = new OneDollar(this);
  recognizer.setVerbose(true);
  addGestures();
  
  recognizer.bind("circle", "detected");
  recognizer.bind("triangle", "detected");
  recognizer.bind("rectangle", "detected");
  recognizer.bind("delete", "detected");

  checkConvert = false;
}



// View /////////////////////////////

void draw() {
  
  // the radius of the circle indicator changes with frameCount.
  cursorRadius = cursorRadius + sin( frameCount / 4 );

  if (crazyOn) {
    canvasColor = model.switchCanvasColor();
  }
  
  background(canvasColor);
  
  
  // draw shapes and selection box, if valid.
  model.drawShapes();
  
  // draw toolbars.
  model.drawToolbars();
  
  // current tool determines the color of the cursor.
  cursorColor = model.getCursorColor();
  
//  recognizer.check();
  
  // draw cursor.
  fill(cursorColor);
  stroke(255);
  strokeWeight(1);
  ellipse(cursorX, cursorY, cursorRadius, cursorRadius);
  
}




// Controller ///////////////////////


void mouseMoved() {
  cursorX = mouseX;
  cursorY = mouseY;
  
  if (!mousePressed) {
    model.hoverCheck(cursorX, cursorY);
  }
}


void mouseClicked() {
  model.clickCheck(mouseX, mouseY);
}



void mousePressed() {
  recognizer.start(100);
  model.clickCheck(mouseX, mouseY);
}



void mouseReleased() {
  recognizer.end(100);
  float lastX = mouseX;
  float lastY = mouseY;
  
  if (!recognized) {
    model.release(lastX, lastY);
  }
}



void mouseDragged() {
  recognizer.update(100, mouseX, mouseY);
  cursorX = mouseX;
  cursorY = mouseY;
  
  model.dragCheck(cursorX, cursorY);  
}


void keyPressed() {
  model.setShiftPressed(false);
  
  if ( ' ' == key) {
    model.switchToolbar();
    
  } else if ('a' == key) {
      model.switchLineWidth();
      
  } else if ('c' == key) {
    model.switchLineColor();
    
  } else if ('j' == key) {
//    model.decreaseR();
    
  } else if ('u' == key) {
//    model.increaseR();
    
  } else if ('k' == key) {
//    model.decreaseG();
    
  } else if ('i' == key) {
//    model.increaseG();
    
  } else if ('l' == key) {
//    model.decreaseB();
    
  } else if ('o' == key) {
//    model.increaseB();
    
  } else if ('s' == key) {
    model.saveCanvas();
    
  } else if ('d' == key) {
    model.deleteSelectedShapes();
    
  } else if ('f' == key) {
    model.clearCanvas();
    
  } else if (SHIFT == keyCode) {
    model.setShiftPressed(true); // used for multiple and lasso selection
    
  } else if ('g' == key) {
    model.scaleUpSelection();
    
  } else if ('h' == key) {
    model.scaleDownSelection();
    
  } else if ('t' == key) {
    model.rotateSelection(radians(30));
    
  } else if ('y' == key) {
    model.rotateSelection(radians(-30));
    
  } else if ('q' == key) {
    canvasColor = model.switchCanvasColor();
    
  } else if ('w' == key) {
    crazyOn = !crazyOn;
  }
  
}


void keyReleased() {
  model.setShiftPressed(false);
}


void detected(String gesture, int x, int y, int cx, int cy) {
  recognized = true;

  int r = (int)dist(x, y, cx, cy);

  if (gesture.equals("circle")) {
    model.addShapeToCanvas(new CircleShape(cx, cy, r));
  
  } else if (gesture.equals("triangle")) {
  
  } else if (gesture.equals("rectangle")) {
  
  } else if (gesture.equals("delete")) {
  
  }
}
  
void addGestures() {
  // add template gestures:
  recognizer.addGesture("triangle", new Integer[] {
    137, 139, 135, 141, 133, 144, 132, 146, 130, 149, 128, 151, 126, 155, 123, 160, 120, 166, 116, 171, 112, 177, 107, 183, 102, 188, 100, 191, 95, 195, 90, 199, 86, 203, 82, 206, 80, 209, 75, 213, 73, 213, 70, 216, 67, 219, 64, 221, 61, 223, 60, 225, 62, 226, 65, 225, 67, 226, 74, 226, 77, 227, 85, 229, 91, 230, 99, 231, 108, 232, 116, 233, 125, 233, 134, 234, 145, 233, 153, 232, 160, 233, 170, 234, 177, 235, 179, 236, 186, 237, 193, 238, 198, 239, 200, 237, 202, 239, 204, 238, 206, 234, 205, 230, 202, 222, 197, 216, 192, 207, 186, 198, 179, 189, 174, 183, 170, 178, 164, 171, 161, 168, 154, 160, 148, 155, 143, 150, 138, 148, 136, 148
  } 
  );
  recognizer.addGesture("circle", new Integer[] {
    127, 141, 124, 140, 120, 139, 118, 139, 116, 139, 111, 140, 109, 141, 104, 144, 100, 147, 96, 152, 93, 157, 90, 163, 87, 169, 85, 175, 83, 181, 82, 190, 82, 195, 83, 200, 84, 205, 88, 213, 91, 216, 96, 219, 103, 222, 108, 224, 111, 224, 120, 224, 133, 223, 142, 222, 152, 218, 160, 214, 167, 210, 173, 204, 178, 198, 179, 196, 182, 188, 182, 177, 178, 167, 170, 150, 163, 138, 152, 130, 143, 129, 140, 131, 129, 136, 126, 139
  } 
  );
  recognizer.addGesture("rectangle", new Integer[] {
    78, 149, 78, 153, 78, 157, 78, 160, 79, 162, 79, 164, 79, 167, 79, 169, 79, 173, 79, 178, 79, 183, 80, 189, 80, 193, 80, 198, 80, 202, 81, 208, 81, 210, 81, 216, 82, 222, 82, 224, 82, 227, 83, 229, 83, 231, 85, 230, 88, 232, 90, 233, 92, 232, 94, 233, 99, 232, 102, 233, 106, 233, 109, 234, 117, 235, 123, 236, 126, 236, 135, 237, 142, 238, 145, 238, 152, 238, 154, 239, 165, 238, 174, 237, 179, 236, 186, 235, 191, 235, 195, 233, 197, 233, 200, 233, 201, 235, 201, 233, 199, 231, 198, 226, 198, 220, 196, 207, 195, 195, 195, 181, 195, 173, 195, 163, 194, 155, 192, 145, 192, 143, 192, 138, 191, 135, 191, 133, 191, 130, 190, 128, 188, 129, 186, 129, 181, 132, 173, 131, 162, 131, 151, 132, 149, 132, 138, 132, 136, 132, 122, 131, 120, 131, 109, 130, 107, 130, 90, 132, 81, 133, 76, 133
  } 
  );
  recognizer.addGesture("delete", new Integer[] {
    123, 129, 123, 131, 124, 133, 125, 136, 127, 140, 129, 142, 133, 148, 137, 154, 143, 158, 145, 161, 148, 164, 153, 170, 158, 176, 160, 178, 164, 183, 168, 188, 171, 191, 175, 196, 178, 200, 180, 202, 181, 205, 184, 208, 186, 210, 187, 213, 188, 215, 186, 212, 183, 211, 177, 208, 169, 206, 162, 205, 154, 207, 145, 209, 137, 210, 129, 214, 122, 217, 118, 218, 111, 221, 109, 222, 110, 219, 112, 217, 118, 209, 120, 207, 128, 196, 135, 187, 138, 183, 148, 167, 157, 153, 163, 145, 165, 142, 172, 133, 177, 127, 179, 127, 180, 125
  } 
  );
  // http://depts.washington.edu/aimgroup/proj/dollar/unistrokes.gif
}

