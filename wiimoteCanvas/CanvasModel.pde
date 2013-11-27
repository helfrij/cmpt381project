public class CanvasModel {
  
  ArrayList<AbstractShape> canvasContents;
  AbstractShape selectedShape;
  
  boolean isDrawing;
  AbstractShape currentShape;
  
  public CanvasModel() {
    canvasContents = new ArrayList<AbstractShape>();
    isDrawing = false;
    currentShape = null;
  }
  
  
  public void setDrawingState(boolean newState) {
    isDrawing = newState;
  }
  
  
  public boolean getDrawingState() {
    return isDrawing; 
  }
  
  
  public void addShape(AbstractShape newShape) {
    if (isDrawing) {
      if (newShape == null) {
        return;
      }
    
    canvasContents.add(newShape);
    }
  }
  
  
  public void startNewShape(AbstractShape newShape) {
     setDrawingState(true);
     currentShape = newShape;
  }
  
  
  public void addToShape(float x, float y) {
    currentShape.addPoint(x, y);
  }
  
  
  public void finishNewShape(float x, float y) {
     if (getDrawingState() && currentShape != null) {
       currentShape.addLastPoint(x, y);
       canvasContents.add(currentShape);
       currentShape = null;
       setDrawingState(false);
     }
  }
  
  
  public void drawShapes() {
    for(AbstractShape shape : canvasContents) {
      shape.drawShape();
    }
  }
  
}
