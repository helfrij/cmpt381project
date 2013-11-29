
private float cursorRadius;
private int cursorX, cursorY;
private color cursorColor;

private int canvasH, canvasW;

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
  
  // set up wiimote listener
  deviceListener = new WiimoteListener();
  
  // set up the model, stores the shapes drawn on the canvas.
  model = new CanvasModel();

  // set up the toolbar, stores the available tools.
  toolbar = new ToolBar(canvasW, canvasH);
}



// View /////////////////////////////

void draw() {
  
  // the radius of the circle indicator changes with frameCount.
  cursorRadius = cursorRadius + sin( frameCount / 4 );
  
  // set the canvas background to grey.
  background(220);
  
  // draw shapes.
  model.drawShapes();
  
  if (drawingShape != null) {
    drawingShape.drawShape(); 
  }
  
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
  }
}


void mouseClicked() {
  toolbar.clickCheck(mouseX, mouseY);
}



void mousePressed() {
  toolbar.pressCheck(mouseX, mouseY);
  
  // if the press landed on the canvas (not on any toolbar items) and the selected tool is valid, begin drawing a new shape.
  if (toolbar.canvasHit(mouseX, mouseY) && toolbar.selectedToolExists()) {
    AbstractShape newShape = toolbar.getSelectedTool().createCanvasShape();
    drawingShape = newShape;
  }
}



void mouseReleased() {
  toolbar.released(mouseX, mouseY); 
  
  if (drawingShape != null) {
    model.addShape(drawingShape); 
  }
  
  drawingShape = null;
}



void mouseDragged() {
  cursorX = mouseX;
  cursorY = mouseY;
  
  toolbar.dragCheck(cursorX, cursorY);
  
  if (drawingShape != null) {
    drawingShape.addPoint(cursorX, cursorY); 
  }
  
}

