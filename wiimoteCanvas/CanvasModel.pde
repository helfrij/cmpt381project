public class CanvasModel {
  
  int toolbarIndex;
  private ArrayList<AbstractToolbar> toolbars;
  NoToolbar noToolbar;
  ToolBar mainToolbar;
  ColorToolbar colorToolbar;

  private ArrayList<AbstractShape> canvasContents;  
//  private ArrayList<AbstractShape> selectedShapes;
  private AbstractShape drawingShape;
  
  private int canvasWidth, canvasHeight;
  private int lineWidth;
  private boolean shiftPressed;
  private boolean selectedPressed;
  
  private boolean crazyOn;
    
  private float mouseDownX;
  private float mouseDownY;

  private CanvasSelectionModel selectionModel;
  
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
//    selectedShapes = new ArrayList<AbstractShape>();
    drawingShape = null;
    
    selectionModel = new CanvasSelectionModel();
    
    recognizer = null;

    lineWidth = 1;
    shiftPressed = false;
    selectedPressed = true;
    
//    lassoSelection = null;
    crazyOn = false;    
    mouseDownX = 0.0;
    mouseDownY = 0.0;
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
    selectionModel.addShapeToSelection(shape);
  }
  
  
  public void clearSelection() {
    selectionModel.clearSelection();
  }
  
  
  private void addShapeToCanvas(AbstractShape newShape) {
    if (newShape != null && !canvasContents.contains(drawingShape)) {
      canvasContents.add(newShape);
    }
  }
  
  
  public void deleteSelectedShapes() {
    selectionModel.deleteSelectedShapes();
  }
  
  
  private void clearCanvas() {
    for (AbstractShape shape : canvasContents) {
      shape.hideShape();
    }
    
    selectionModel.clearSelection();
    canvasContents.clear();
  }
  
  
  public void setDrawingShape(AbstractShape newShape) {
    if (newShape != null) {
      drawingShape = newShape;
      
      selectionModel.clearSelection();
      selectionModel.addShapeToSelection(drawingShape);
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
      shape.drawShape();
    }
    
    // if we are in the middle of drawing a shape, draw what we have.
    if (drawingShape != null) {
      drawingShape.drawShape(); 
    }
    
    // if we are making a lasso selection, draw the selection box too!
    selectionModel.drawSelectionBox();
//    drawSelectionBox();
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
    selectionModel.scaleUpSelection();
  }
  
  
  public void scaleDownSelection() {
    selectionModel.scaleDownSelection();
  }
  
  
  public void rotateSelection(float dAngle) {
    selectionModel.rotateSelection(dAngle);
  }
  
  
  public void clickCheck(float xPos, float yPos) {    

    // if a part of empty canvas was clicked, then we begin lasso selection OR creating a new shape.
    if (canvasHit(xPos, yPos)) {
      if (shiftPressed) {
        clearSelection();
        selectionModel.startSelectionBox(xPos, yPos);
        
      } else {
        selectionModel.clearSelection();
        AbstractShape newShape = mainToolbar.createNewShape();
        setDrawingShape(newShape);
      }
      
    // if one of the toolbars was hit, forward the "clickCheck" to whichever toolbar was hit.
    } else if (toolbarHit(xPos, yPos)) {
      
      selectionModel.clearSelection();
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
            selectionModel.clearSelection();
          }
          
          selectionModel.addShapeToSelection(shape);
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
      selectionModel.translateX(cursorX - mouseDownX);
      selectionModel.translateY(cursorY - mouseDownY);
      
      mouseDownX = cursorX;
      mouseDownY = cursorY;
    }
    
    // else we could be in the middle of a lasso selection!
    if (shiftPressed()) {
      selectionModel.updateLassoEndpoint(cursorX, cursorY);
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
//    if (lassoSelection != null) {
      for (AbstractShape shape : canvasContents) {
        if (selectionModel.boxContains(shape)) {
          selectionModel.addShapeToSelection(shape);
        }
//        if (selectionModel.boxContainsX(shape.getShapeCenterX()) && selectionModel.boxContainsY(shape.getShapeCenterY())) {
//          selectionModel.addShapeToSelection(shape);
//        }
      }
//    }
    
    selectionModel.hideSelectionBox();
    
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
    selectionModel.setSelectionLineColor(newColor);
    
//    for (AbstractShape shape : selectedShapes) {
//      shape.setLineColor(newColor);
//    }
  }
  
  
  public void switchLineWidth() {
    lineWidth++;
    
    if (lineWidth > 4) {
      lineWidth = 1; 
    }
    
    selectionModel.setSelectionLineWidth(lineWidth);
    
//    for (AbstractShape shape : selectedShapes) {
//      shape.setLineWidth(lineWidth);
//    }
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
  
  
//  public void checkRecognizer() {
////    recognizer.check();
//  }

}
  
  

