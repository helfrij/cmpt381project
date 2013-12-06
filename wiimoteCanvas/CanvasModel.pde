public class CanvasModel {
  
  int toolbarIndex;
  private ArrayList<AbstractToolbar> toolbars;
  NoToolbar noToolbar;
  ToolBar mainToolbar;
  ColorToolbar colorToolbar;
  
  OneDollar recognizer;

  private ArrayList<AbstractShape> canvasContents;  
  private ArrayList<AbstractShape> selectedShapes;
  private AbstractShape drawingShape;
  
  private int canvasWidth, canvasHeight;
  private int lineWidth;
  private boolean shiftPressed;
  private boolean selectedPressed;
  
  private boolean crazyOn;
    
  private float mouseDownX;
  private float mouseDownY;

  private SelectionBox lassoSelection; // maybe we need to implement a separate selection model?
  
  public CanvasModel(int w, int h) {
    canvasWidth = w;
    canvasHeight = h;
    
    toolbarIndex = 0;
    toolbars = new ArrayList<AbstractToolbar>();
    
    noToolbar = new NoToolbar();
    addToolbar(noToolbar);
    
    mainToolbar = new ToolBar(canvasWidth, canvasHeight);
    addToolbar(mainToolbar);
    
    colorToolbar = new ColorToolbar(canvasWidth, canvasHeight);
    addToolbar(colorToolbar);
    
    canvasContents = new ArrayList<AbstractShape>();
    selectedShapes = new ArrayList<AbstractShape>();
    drawingShape = null;
    
    recognizer = null;

    lineWidth = 1;
    shiftPressed = false;
    selectedPressed = true;
    
    lassoSelection = null;
    crazyOn = false;    
    mouseDownX = 0.0;
    mouseDownY = 0.0;
  }
  
  
  public void startSelectionBox(float startX, float startY) {
    lassoSelection = new SelectionBox(startX, startY);
    lassoSelection.hide();
  }
  
  
  public void drawSelectionBox() {
    if (lassoSelection != null) {
      lassoSelection.show();
      lassoSelection.drawSelectionBox();
    }
  }
  
  
  public void hideSelectionBox() {
    if (lassoSelection != null) {
      lassoSelection.hide();
    }
    
    lassoSelection = null;
  }
  
  
  public void setSelectedPressed(boolean isPressed) {
    selectedPressed = isPressed;
  }
  
  
  public boolean selectedPressed() {
    return selectedPressed;
  }
  
  
  public void addToolbar(AbstractToolbar newToolbar) {
    if (newToolbar != null && !toolbars.contains(newToolbar)) {
      toolbars.add(newToolbar);
    }
  }
  
  
  public void hideToolbars() {
    for (AbstractToolbar toolbar : toolbars) {
      toolbar.hideToolbar();
    }
  }
  
  
  public void drawToolbars() {
    for (AbstractToolbar toolbar : toolbars) {
      toolbar.drawToolbar();
    }
  }
  
  
  public color getCursorColor() {
    return mainToolbar.getCursorColor();
  }
  

  private void addShapeToSelection(AbstractShape shape) {
    if (shape != null && !selectedShapes.contains(shape)) {
      shape.setSelected(true);
      selectedShapes.add(shape); 
    }
  }
  
  
  public void clearSelection() {
    for(AbstractShape shape : selectedShapes) {
      shape.setSelected(false);
    }
    
    selectedShapes.clear();
  }
  
  
  private void addShapeToCanvas(AbstractShape newShape) {
    if (newShape != null && !canvasContents.contains(drawingShape)) {
      canvasContents.add(newShape);
    }
  }
  
  
  public void deleteSelectedShapes() {
    for (AbstractShape shape : selectedShapes) {
      shape.hideShape(); 
    }
    
    clearSelection();
  }
  
  
  private void clearCanvas() {
    for (AbstractShape shape : canvasContents) {
      shape.hideShape();
    }
    
    clearSelection();
    canvasContents.clear();
  }
  
  
  public void setDrawingShape(AbstractShape newShape) {
    if (newShape != null) {
      drawingShape = newShape;
//      color lineColor = color(colours[colorIndex][0], colours[colorIndex][1], colours[colorIndex][2]);
//      drawingShape.setLineColor(lineColor);
      
      clearSelection();
      selectedShapes.add(drawingShape); 
    }
  }
  
  
  public void drawShape(float newX, float newY) {
    if (drawingShape != null) {
      drawingShape.addPoint(newX, newY);
    }
  }
  
  
  public void addDrawingToCanvas() {
    addShapeToCanvas(drawingShape);
    drawingShape = null;
  }
  
  
  public void drawShapes() {
    // draw the shapes that have been created and saved thus far.
    for(AbstractShape shape : canvasContents) {
//      if (crazyOn) {
//        shape.switchLineColor();
//      }
      
      shape.drawShape();
    }
    
    // if we are in the middle of drawing a shape, draw what we have.
    if (drawingShape != null) {
      drawingShape.drawShape(); 
    }
    
    // if we are making a lasso selection, draw the selection box too!
    drawSelectionBox();
  }
  
  
  public boolean shapeHit(float clickX, float clickY) {
    
    for (AbstractShape shape : canvasContents) {
      if (shape.checkHit(clickX, clickY) == true) {
        return true;
      }
    }
    
    return false;
  }
  
  
  public boolean selectedToolExists() {
    return mainToolbar.selectedToolExists();
  }
  
  
  public void setShiftPressed(boolean isPressed) {
    shiftPressed = isPressed;
  }
  
  
  public boolean shiftPressed() {
    return shiftPressed;
  }
  
  
  public void scaleUpSelection() {
    for (AbstractShape shape : selectedShapes) {
      float scale = shape.getScale();
      shape.setScale(scale + 0.1);
    }
  }
  
  
  public void scaleDownSelection() {
    for (AbstractShape shape : selectedShapes) {
      float scale = shape.getScale();
      shape.setScale(scale - 0.1);
    }
  }
  
  
  public void rotateSelection(float dAngle) {
    for (AbstractShape shape : selectedShapes) {
      float oldAngle = shape.getRotationAngle();
      float newAngle = oldAngle + dAngle;
      shape.setRotationAngle(newAngle);
    }
  }
  
  
  public void clickCheck(float xPos, float yPos) {    

    // if a part of empty canvas was clicked, then we begin lasso selection OR creating a new shape.
    if (canvasHit(xPos, yPos)) {
      if (shiftPressed) {
        clearSelection();
        startSelectionBox(xPos, yPos);
        
      } else {
        clearSelection();
        AbstractShape newShape = mainToolbar.createNewShape();
        setDrawingShape(newShape);
      }
      
    // if one of the toolbars was hit, forward the "clickCheck" to whichever toolbar was hit.
    } else if (toolbarHit(xPos, yPos)) {
      
      clearSelection();
      for (AbstractToolbar toolbar : toolbars) {
        toolbar.clickCheck(xPos, yPos);
      }
      
    // if one of the shapes drawn on the canvas was hit, add that shape to selection.
    } else if (shapeHit(xPos, yPos)) {
      
      for (AbstractShape shape : canvasContents) {
        if (shape.checkHit(xPos, yPos)) {
          
          // if we're pressing on an already selected shape, this is the signal to start moving shapes around.
          if (shape.isSelected()) {
            setSelectedPressed(true);
            mouseDownX = xPos;
            mouseDownY = yPos;
          }
          
          // if we just clicked on a random shape, clear old selection. this will be the new selection.
          if (!shiftPressed() && !selectedPressed()) {
            clearSelection();
          }
          
          addShapeToSelection(shape);
        }
      }
    }
  }
  
  
  public void hoverCheck(float xPos, float yPos) {
    // check to see if we are hovering over a canvas shape.
    for (AbstractShape shape : canvasContents) {
      if (shape.checkHit(xPos, yPos) == true) {
        shape.setHoverSelected(true);
      } else {
        shape.setHoverSelected(false);
      }
    }
    
    // check if we are hovering over a toolbar.
    for (AbstractToolbar toolbar : toolbars) {
      toolbar.hoverCheck(xPos, yPos);
    }
  }
  
  
  public boolean toolbarHit(float clickX, float clickY) {
    for (AbstractToolbar toolbar : toolbars) {
      if (toolbar.toolbarHit(clickX, clickY)) {
        return true;
      }
    }
    
    return false;
  }
  
  
  public void dragCheck(float cursorX, float cursorY) {
    // if we are drawing on the canvas, the drawing shape will not be null. Add new points to the shape.
    drawShape(cursorX, cursorY);
      
    // we could be dragging a toolbar around. Forward the call to the toolbars to handle it themselves.
    for (AbstractToolbar toolbar : toolbars) {
      toolbar.dragCheck(cursorX, cursorY);
    } 
    
    // if mouseDown happened on a selected shape(s), we can drag the selection around on the canvas.
    if (selectedPressed()) {
      for (AbstractShape shape : selectedShapes) {
        shape.translateX(cursorX - mouseDownX);
        shape.translateY(cursorY - mouseDownY);
      }
      
      mouseDownX = cursorX;
      mouseDownY = cursorY;
    }
    
    // else we could be in the middle of a lasso selection!
    if (shiftPressed() && lassoSelection != null) {
      lassoSelection.updateEndpoint(cursorX, cursorY);
    }
  }
  
  
  public void release(float lastX, float lastY) {
    // if we've been drawing a new shape, the drawing is now complete. Add drawing to list of canvas items.
    addDrawingToCanvas();
    
    // if we've been dragging around a toolbar, let the toolbar release itself!
    for (AbstractToolbar toolbar : toolbars) {
      toolbar.release(lastX, lastY);
    }
    
    // if we've been dragging the cursor to form a selection box, the box is now complete. All interior shapes should now be selected.
    if (lassoSelection != null) {
      for (AbstractShape shape : canvasContents) {
        if (lassoSelection.containsX(shape.getShapeCenterX()) && lassoSelection.containsY(shape.getShapeCenterY())) {
          addShapeToSelection(shape);
        }
      }
    }
    
    hideSelectionBox();
    
    // if we've been dragging around a selected shape(s) on the canvas, time to restore defaults.
    mouseDownX = 0.0;
    mouseDownY = 0.0;
    setSelectedPressed(false);
  }
  
  
  public boolean canvasHit(float clickX, float clickY) {
    // if either a shape or a toolbar was hit with the click, return false.
    if (shapeHit(clickX, clickY) || toolbarHit(clickX, clickY)) {
      return false;
    }
    // otherwise, part of the blank canvas was hit!
    return true;
  }
  
  
  public void saveCanvas() {
    hideToolbars();
    toolbarIndex = 0;
    save("canvas.jpg");
  }
  
  
  public void switchLineColor() {
    color newColor = colorToolbar.switchLineColor();
    
    for (AbstractShape shape : selectedShapes) {
      shape.setLineColor(newColor);
    }
  }
  
  
  public void switchLineWidth() {
    lineWidth++;
    
    if (lineWidth > 4) {
      lineWidth = 1; 
    }
    
    for (AbstractShape shape : selectedShapes) {
      shape.setLineWidth(lineWidth);
    }
  }
  
  
  public void switchToolbar() {
    int toolbarNum = toolbars.size();
    
    hideToolbars();
    toolbarIndex++;
    
    if (toolbarIndex >= toolbarNum) {
      toolbarIndex = 0;
    }
        
    if (toolbarIndex < toolbars.size()) {
      toolbars.get(toolbarIndex).showToolbar();
    }
  }
  
  
//  public color getCanvasColor() {
//    return colorToolbar.getCanvasColor();
//  }
  
  
  public color switchCanvasColor() {
    return colorToolbar.switchCanvasColor();
  }
  
  public void setCrazyOn(boolean isOn) {
    crazyOn = isOn;
//    colorToolbar.setCrazyOn(true);
  }
  
  
  public void initializeRecognizer(OneDollar newRecognizer) {
    recognizer = newRecognizer;
    recognizer.setVerbose(true);
    addGestures();
    
    recognizer.bind("circle", "detected");
    recognizer.bind("triangle", "detected");
    recognizer.bind("rectangle", "detected");
    recognizer.bind("delete", "detected");
    
  }
  
  
  public void checkRecognizer() {
//    recognizer.check();
  }
  
  
  public void detected(String gesture, int x, int y, int cx, int cy) {
//  recognized = true;
  
    int r = (int)dist(x, y, cx, cy);
  
    if (gesture.equals("circle")) {
//    model.addShape(new CircleShape(cx, cy, r));
    
    } else if (gesture.equals("triangle")) {
    
    } else if (gesture.equals("rectangle")) {
    
    } else if (gesture.equals("delete")) {
    
    }
  }
  
  public void addGestures() {
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
  
}
