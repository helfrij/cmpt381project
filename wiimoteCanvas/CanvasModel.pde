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
  
  
  private void addShapeToCanvas(AbstractShape newShape) {
    if (newShape != null && !canvasContents.contains(drawingShape)) {
      canvasContents.add(newShape);
    }
  }
  
  
  public void deleteSelectedShapes() {
    for (AbstractShape shape : selectedShapes) {
      shape.hideShape(); 
    }
    
    clearSelectedShapes();
  }
  
  
  private void clearSelectedShapes() {
    for (AbstractShape shape : selectedShapes) {
      shape.setSelected(false);
    }
    
    selectedShapes.clear();
  }
  
  
  public void setDrawingShape(AbstractShape newShape) {
    if (newShape != null) {
      drawingShape = newShape;
//      color lineColor = color(colours[colorIndex][0], colours[colorIndex][1], colours[colorIndex][2]);
//      drawingShape.setLineColor(lineColor);
      
      clearSelectedShapes();
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
    for(AbstractShape shape : canvasContents) {
      shape.drawShape();
    }
    
    if (drawingShape != null) {
      drawingShape.drawShape(); 
    }
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
  
  
  public void clickCheck(float xPos, float yPos) {
    clearSelectedShapes();
    
    // if a part of empty canvas was clicked, then we begin creating a new shape.
    if (canvasHit(xPos, yPos)) {
      AbstractShape newShape = mainToolbar.createNewShape();
      setDrawingShape(newShape);
      
    // if one of the toolbars was hit, forward the "clickCheck" to whichever toolbar was hit.
    } else if (toolbarHit(xPos, yPos)) {
      
      for (AbstractToolbar toolbar : toolbars) {
        toolbar.clickCheck(xPos, yPos);
      }
      
    // if one of the shapes drawn on the canvas was hit, set that shape as the selected shape.
    } else if (shapeHit(xPos, yPos)) {
      
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
  }
  
  
  public void release(float lastX, float lastY) {
    addDrawingToCanvas();
    
    for (AbstractToolbar toolbar : toolbars) {
      toolbar.release(lastX, lastY);
    }
  }
  
  
  public boolean canvasHit(float clickX, float clickY) {
    // if either a shape or a toolbar was hit with the click, return false.
    if (shapeHit(clickX, clickY) || toolbarHit(clickX, clickY)) {
      return false;
    }
    // otherwise, part of the blank canvas was hit!
    return true;
  }
  
  
  public void saveDrawing() {
//    AbstractToolbar selectedToolbar;
//    selectedToolbar.hideToolbar();
    save("canvas.jpg");
//    setSelectedToolbar(selectedToolbar);
  }
  
  
  public void switchLineColor() {
//    color newColor = colorToolbar.switchLineColor();
//    
//    for (AbstractShape shape : selectedShapes) {
//      shape.setLineColor(newColor);
//    }
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
