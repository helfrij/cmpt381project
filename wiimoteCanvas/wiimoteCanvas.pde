
private float cursorRadius;
private int cursorX, cursorY;
private color cursorColor;

private int canvasH, canvasW;


private WiiRemoteJ deviceFinder;
private WiiRemote remote;
private WiimoteListener deviceListener;
private ToolBar toolbar;
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
  
  // set up the model, stores the shapes drawn on the canvas.
  model = new CanvasModel();

  // set up the toolbar, stores the available tools.
  toolbar = new ToolBar(canvasW, canvasH);
}


public void saveCanvas() {
  toolbar.hideToolbar();
  model.saveDrawing();
  toolbar.showToolbar();
}


public void switchColor() {
  model.switchColor();
}


public void switchLineWidth() {
  model.switchLineWidth(); 
}



// View /////////////////////////////

void draw() {
  
  // the radius of the circle indicator changes with frameCount.
  cursorRadius = cursorRadius + sin( frameCount / 4 );
  
  // set the canvas background to grey.
  background(220);
  
  // draw shapes.
  model.drawShapes();
  
  // draw toolbar.
  toolbar.drawToolBar();
  cursorColor = toolbar.getCursorColor();
  
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
    toolbar.hoverCheck(cursorX, cursorY);
    model.hoverCheck(cursorX, cursorY);
  }
}


void mouseClicked() {
  toolbar.clickCheck(mouseX, mouseY);
  model.clickCheck(mouseX, mouseY);
}



void mousePressed() {
  toolbar.pressCheck(mouseX, mouseY);
  model.clickCheck(mouseX, mouseY);
  
  // if the press landed on the canvas (not on any toolbar items) and the selected tool is valid, begin drawing a new shape.
  if (toolbar.canvasHit(mouseX, mouseY) && toolbar.selectedToolExists() && model.canvasHit(mouseX, mouseY)) {
    AbstractShape newShape = toolbar.getSelectedTool().createCanvasShape();
    model.setDrawingShape(newShape);
  }
}



void mouseReleased() {
  toolbar.released(mouseX, mouseY); 
  model.addDrawingToCanvas();
}



void mouseDragged() {
  cursorX = mouseX;
  cursorY = mouseY;
  
  toolbar.dragCheck(cursorX, cursorY);
  model.drawShape(cursorX, cursorY);
  
}


void keyPressed() {
//  if(CODED == key) {
//    if(SHIFT == keyCode) {
//      control = !control;
//    }
//  }
//  else {
//    if(('a' == key) && (lineWidth<=20)) {
//      lineWidth++;
//    }
//    else if(('s' == key) && (lineWidth>0)) {
//      lineWidth--;
//    }
//    else if(('c' == key) && (fillColour<5)) {
//      fillColour++;
//    }
//    else if(('c' == key) && (5==fillColour)) {
//      fillColour = 0;
//    }
//    else if(('v' == key) && (fillColour>0)) {
//      fillColour--;
//    }
//    else if(('v' == key) && (0 == fillColour)) {
//      fillColour = 5;
//    }
//  }
}

