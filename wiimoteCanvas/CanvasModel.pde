public class CanvasModel {
  
  int toolbarIndex;
  private ArrayList<AbstractToolbar> toolbars;
  private ArrayList<AbstractShape> canvasContents;  
  private ArrayList<AbstractShape> selectedShapes;
  private AbstractShape drawingShape;
  
  private int canvasWidth, canvasHeight;
  
  private int[][] colours;
  private int colorIndex;
  private int rVal, gVal, bVal;

  private int []black = {0, 0, 0};
  private int[] red = {255, 0, 0};
  private int[] orange = {255, 165, 0};
  private int[] yellow = {255, 255, 0};
  private int[] green = {34, 139, 34};
  private int[] blue = {0, 191, 255};
  private int[] indigo = {75, 0, 130}; 
  private int[] violet = {148, 0, 211};
  
  private int lineWidth;

  
  
  public CanvasModel(int w, int h) {
    canvasWidth = w;
    canvasHeight = h;
    
    toolbarIndex = 0;
    toolbars = new ArrayList<AbstractToolbar>();
    canvasContents = new ArrayList<AbstractShape>();
    selectedShapes = new ArrayList<AbstractShape>();
    drawingShape = null;
    
    rVal = 0;
    gVal = 0;
    bVal = 0;
    
    // create a list of colors to select from for the shapes.
    colorIndex = 0;
    colours = new int[8][3];
    colours[0] = black;
    colours[1] = red;
    colours[2] = orange;
    colours[3] = yellow;
    colours[4] = green;
    colours[5] = blue;
    colours[6] = indigo;
    colours[7] = violet;   

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
  

  private void addShapeToSelection(AbstractShape shape) {
    if (shape != null) {
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
      color lineColor = color(colours[colorIndex][0], colours[colorIndex][1], colours[colorIndex][2]);
      drawingShape.setLineColor(lineColor);
      
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
  
  
  public void clickCheck(float xPos, float yPos) {
    clearSelectedShapes();
      
    for (AbstractShape shape : canvasContents) {
      if (shape.checkHit(xPos, yPos) == true) {
        shape.setSelected(true);
        addShapeToSelection(shape);
      }
    }
  }
  
  
  public void hoverCheck(float xPos, float yPos) {
    for (AbstractShape shape : canvasContents) {
      if (shape.checkHit(xPos, yPos) == true) {
        shape.setHoverSelected(true);
      } else {
        shape.setHoverSelected(false);
      }
    }
  }
  
  
  public boolean canvasHit(float clickX, float clickY) {
    if (shapeHit(clickX, clickY) == false) {
      return true;
    }
    
    return false;
  }
  
  
  public void saveDrawing() {
    save("canvas.jpg");
  }
  
  
  public void switchLineColor() {
    colorIndex++;
    
    if (colorIndex > colours.length - 1) {
      colorIndex = 0;
    }
    
    rVal = colours[colorIndex][0];
    gVal = colours[colorIndex][1];
    bVal = colours[colorIndex][2];
    
    color newColor = color(rVal, gVal, bVal);
    
    for (AbstractShape shape : selectedShapes) {
      shape.setLineColor( newColor );
    }
  }
  
  
  public void decreaseR() {
    rVal--;
    
    if (rVal < 0) {
      rVal = 0;
    }
  }
  
  
  public void increaseR() {
    rVal++;
    
    if (rVal > 255) {
      rVal = 255; 
    }
  }
  
  
  public void decreaseG() {
    gVal--;
    
    if (gVal < 0) {
      gVal = 0;
    }
  }
  
  
  public void increaseG() {
    gVal++;
    
    if (gVal > 255) {
      gVal = 255;
    }
  }
  
  
  public void decreaseB() {
    bVal--;
    
    if (bVal < 0) {
      bVal = 0;
    }
  }
  
  
  public void increaseB() {
    bVal++;
    
    if (bVal > 255) {
      bVal = 255;
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
