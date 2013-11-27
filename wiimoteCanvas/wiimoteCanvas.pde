
float cursorRadius = 5.0;
int cursorX, cursorY;
color cursorColor;

int canvasH, canvasW;

int toolbarX, toolbarY;

ToolBar toolbar;
CanvasModel model;

//////////////////////////////////////////////////////////////

void setup() {
  
  // set canvas dimensions.
  canvasW = 1000;
  canvasH = 700;
  
  // set the coordinates of the top left corner of the toolbar.
  toolbarX = canvasW/100;
  toolbarY = canvasH/100;
  
  // set canvas size.
  size(canvasW, canvasH);
  
  // set the initial position of the cursor.
  cursorX = width / 2;
  cursorY = height / 2;
  
  // do not display default cursor
  noCursor();
  
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
  background(209);
  
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
  
  toolbar.hoverCheck(cursorX, cursorY);
}


void mouseClicked() {
  int clickX = mouseX;
  int clickY = mouseY;
  
  toolbar.clickCheck(clickX, clickY);
  
}



void mousePressed() {
  int pressX = mouseX;
  int pressY = mouseY;
  
  toolbar.pressCheck(pressX, pressY);
  
  // if the press landed on the canvas (not on any toolbar items) and the selected tool is valid, begin drawing a new shape.
  if (toolbar.getDrawingState(pressX, pressY) && toolbar.selectedToolExists()) {
    AbstractShape newShape = toolbar.getSelectedTool().createCanvasObject();
    model.startNewShape(newShape);
  }
}



void mouseReleased() {
  float lastX = mouseX;
  float lastY = mouseY;
  
  toolbar.released(lastX, lastY); 
  model.finishNewShape(lastX, lastY);
}



void mouseDragged() {
  cursorX = mouseX;
  cursorY = mouseY;
  
  toolbar.dragCheck(cursorX, cursorY);
  
  if (model.getDrawingState()) {
    model.addToShape(cursorX, cursorY);
  }
  
}

