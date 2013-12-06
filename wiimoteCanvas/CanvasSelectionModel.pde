public class CanvasSelectionModel {
  
  ArrayList<AbstractShape> selectedShapes;
  private SelectionBox lassoSelection;

  
  
  public CanvasSelectionModel() {
    selectedShapes = new ArrayList<AbstractShape>();
    lassoSelection = null;
  }
  
  
  public void clearSelection() {
    for(AbstractShape shape : selectedShapes) {
      shape.setSelected(false);
    }
    
    selectedShapes.clear();
  }
  
  
  public void addShapeToSelection(AbstractShape shape) {
    if (shape != null && !selectedShapes.contains(shape)) {
      shape.setSelected(true);
      selectedShapes.add(shape); 
    }
  }
  
  
  public void deleteSelectedShapes() {
    for (AbstractShape shape : selectedShapes) {
      shape.hideShape(); 
    }
    
    clearSelection();
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
  
  
  public void setSelectionLineColor(color newColor) {
    for (AbstractShape shape : selectedShapes) {
      shape.setLineColor(newColor);
    }
  }
  
  
  public void setSelectionLineWidth(int newWidth) {
    for (AbstractShape shape : selectedShapes) {
      shape.setLineWidth(newWidth);
    }
  }
  
  
  public void translateX(float dx) {
    for(AbstractShape shape : selectedShapes) {
      shape.translateX(dx);
    }
  }
  
  
  public void translateY(float dy) {
    for(AbstractShape shape : selectedShapes) {
      shape.translateY(dy);
    }
  }
  
  
    public void startSelectionBox(float startX, float startY) {
    
    if (lassoSelection == null) {
      lassoSelection = new SelectionBox(startX, startY);
      
    } else {
      lassoSelection.setStartPoint(startX, startY);
    }
    
    lassoSelection.hide();
  }
  
  
  public void updateLassoEndpoint(float endX, float endY) {
    if (lassoSelection != null) {
      lassoSelection.updateEndpoint(endX, endY);
    }
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
  
  
  public boolean boxContainsX(float xVal) {
    if (lassoSelection != null) {
      return lassoSelection.containsX(xVal);
    }
    
    return false;
  }
  
  
  public boolean boxContainsY(float yVal) {
    if (lassoSelection != null) {
      return lassoSelection.containsY(yVal);
    }
    
    return false;
  }
  
  
  public boolean boxContains(AbstractShape shape) {
    float shapeX = shape.getShapeCenterX();
    float shapeY = shape.getShapeCenterY();
    
    return boxContainsX(shapeX) && boxContainsY(shapeY);
  }
  
  
  public void pressCheck(float xPos, float yPos) {
    
  }
  
  
  public void clickCheck(float xPos, float yPos) {
    
  }
  
}
