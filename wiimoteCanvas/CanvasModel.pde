public class CanvasModel {
  
  ArrayList<AbstractShape> canvasContents;  
  AbstractShape currentShape;
  
  
  public CanvasModel() {
    canvasContents = new ArrayList<AbstractShape>();
    currentShape = null;
  }
  
  
  public AbstractShape getCurrentShape() {
    return currentShape; 
  }
  
  
  public void setCurrentShape(AbstractShape shape) {
    currentShape = shape;
  }
  
  
  public void addShape(AbstractShape newShape) {
    if (newShape != null) {
      canvasContents.add(newShape);
    }
  }
  
  
//  public void startNewShape(AbstractShape newShape, float xPos, float yPos) {
//     setCurrentShape(newShape);
//     
//     if (currentShape != null) {
//       currentShape.addPoint(xPos, yPos);
//     }
//  }
  
  
//  public void addToShape(float x, float y) {
//    if (currentShape != null) {
//      currentShape.addPoint(x, y);
//    }
//  }
  
  
//  public void finishNewShape(float x, float y) {
//     if (currentShape != null) {
//       currentShape.addLastPoint(x, y);
//       addShape(currentShape);
//       currentShape = null;
//     }
//  }
  
  
  public void deleteShape() {
    if (currentShape != null) {

    }
  }
  
  
  public void drawShapes() {
    for(AbstractShape shape : canvasContents) {
      shape.drawShape();
    }
  }
  
}
