public class CanvasModel {
  
  int toolbarIndex;
  private ArrayList<AbstractToolbar> toolbars;
  NoToolbar noToolbar;
  ToolBar mainToolbar;
  ColorToolbar colorToolbar;

  
  private ArrayList<AbstractShape> canvasContents;  
  private ArrayList<AbstractShape> selectedShapes;
  private AbstractShape drawingShape;
  
  private int canvasWidth, canvasHeight;
  private int lineWidth;
  private boolean shiftPressed;

  private SelectionBox lassoSelection;
  
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

    lineWidth = 1;
    shiftPressed = false;
    
    lassoSelection = null;
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
    if (shape != null) {
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
      
      if (!shiftPressed()) {
        clearSelection();
      }
      
      for (AbstractShape shape : canvasContents) {
        if (shape.checkHit(xPos, yPos)) {
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
      
    // else, we could be dragging a toolbar around. Forward the call to the toolbars to handle it themselves.
    
    for (AbstractToolbar toolbar : toolbars) {
      toolbar.dragCheck(cursorX, cursorY);
    } 
    
    // else we are in the middle of a lasso selection!
    if (shiftPressed() && lassoSelection != null) {
      lassoSelection.updateEndpoint(cursorX, cursorY);
//      lassoSelection.drawSelectionBox();
    }
  }
  
  
  public void release(float lastX, float lastY) {
    addDrawingToCanvas();
    
    for (AbstractToolbar toolbar : toolbars) {
      toolbar.release(lastX, lastY);
    }
    
    if (lassoSelection != null) {
      for (AbstractShape shape : canvasContents) {
        if (lassoSelection.containsX(shape.getShapeCenterX()) && lassoSelection.containsY(shape.getShapeCenterY())) {
          addShapeToSelection(shape);
        }
      }
    }
    
    hideSelectionBox();
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
  
}
