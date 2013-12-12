import de.voidplus.dollar.*;
//import Wiigee/

private float cursorRadius;
private int cursorX, cursorY;
private color cursorColor;

private int canvasH, canvasW;
private color canvasColor;
private boolean crazyOn;

private WiiRemoteJ deviceFinder;
private WiiRemote remote;
private WiimoteListener deviceListener;

//private WiimoteWiigee wiigee;

private CanvasModel model;

private AbstractShape drawingShape;

//////////////////////////////////////////////////////////////

void setup() {
  
  System.setProperty("bluecove.jsr82.psm_minimum_off", "true");
  
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
  deviceFinder = new WiiRemoteJ();

  // Find and connect wiimote  
  
//  try {
//    remote = deviceFinder.findRemote();
//    if(null != remote) {
//      println("Remote connected!");
//      remote.vibrateFor(1000);
//    }
//  } catch(InterruptedException ie) {
//      println("Interrupted Exception caught!");
//  } catch(IOException ioe) {
//      println("IOException caught!");
//  }
  

  
  // set up wiimote listener
//  deviceListener = new WiimoteListener();
//  remote.addWiiRemoteListener(deviceListener);
//  
  
  // set up the model, stores the shapes drawn on the canvas and toolbars.
  model = new CanvasModel(canvasW, canvasH);
  
  canvasColor = color(220);
    
  // set up the shape recognizer.
  //OneDollar newRecognizer = new OneDollar(this);
  //model.initializeRecognizer(newRecognizer);

}



// View /////////////////////////////

void draw() {
  
  // the radius of the circle indicator changes with frameCount.
  cursorRadius = cursorRadius + sin( frameCount / 4 );
  
  // set the canvas background to grey.
//  background(220);

  if (crazyOn) {
    canvasColor = model.switchCanvasColor();
  }
  
  background(canvasColor);
  
  model.checkRecognizer();
  
  // draw shapes and selection box, if valid.
  model.drawShapes();
  
  // draw toolbars.
  model.drawToolbars();
  
  // current tool determines the color of the cursor.
  cursorColor = model.getCursorColor();
  
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
//  recognizer.start(100);
  model.clickCheck(mouseX, mouseY);
}



void mouseReleased() {
  float lastX = mouseX;
  float lastY = mouseY;
  
  model.release(lastX, lastY);
}



void mouseDragged() {
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
    
  } else if ('y' == key) {s
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

