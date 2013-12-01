public class CanvasModel {
  
  private ArrayList<AbstractShape> canvasContents;  
  private ArrayList<AbstractShape> selectedShapes;
  private AbstractShape drawingShape;
  private color[] colours;
  private int colorIndex;
  private int lineWidth;
  
  
  public CanvasModel() {
    canvasContents = new ArrayList<AbstractShape>();
    selectedShapes = new ArrayList<AbstractShape>();
    drawingShape = null;
    
    // create a list of colors to select from for the shapes.
    colorIndex = 0;
    colours = new color[10];
    colours[0] = color(0, 0, 0); // black
    colours[1] = color(255, 0, 0); // red
    colours[2] = color(255/2, 255/3, 0); // orange
    colours[3] = color(255/3, 255/2, 0); // yellow
    colours[4] = color(0, 255, 0); // green
    colours[5] = color(0, 0, 255); // blue
    colours[6] = color(255/3, 0, 255); // indigo
    colours[7] = color(255, 0, 255); // violet
    
    lineWidth = 1;
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
      drawingShape.setLineColor(colours[colorIndex]);
      
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
  
  
  public void switchColor() {
    colorIndex++;
    if (colorIndex > colours.length - 1) {
      colorIndex = 0;
    }
    
    for (AbstractShape shape : selectedShapes) {
      shape.setLineColor( color( colours[colorIndex] ) );
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
  
}
