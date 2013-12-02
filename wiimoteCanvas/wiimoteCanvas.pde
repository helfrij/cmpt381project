
private float cursorRadius;
private int cursorX, cursorY;
private color cursorColor;

private int canvasH, canvasW;


private WiiRemoteJ deviceFinder;
private WiiRemote remote;
private WiimoteListener deviceListener;

private CanvasModel model;

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
  deviceListener = new WiimoteListener();
  
  // set up the model, stores the shapes drawn on the canvas and toolbars.
  model = new CanvasModel(canvasW, canvasH);

}


public void saveCanvas() {
  model.hideToolbars();
  model.saveDrawing();
}



// View /////////////////////////////

void draw() {
  
  // the radius of the circle indicator changes with frameCount.
  cursorRadius = cursorRadius + sin( frameCount / 4 );
  
  // set the canvas background to grey.
  background(220);
  
  // draw shapes.
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
    saveCanvas();
  }
}

