public class SketchShape extends AbstractShape {
  
  int lineWeight;
  color lineColor;
  
  FloatList xCoords;
  FloatList yCoords;
  
  int pointCount;
  
  
  public SketchShape(float firstX, float firstY) {
    pointCount = 0;
    addPoint(firstX, firstY);
    isSelected = false;
  }
  
  
  public void addPoint(float x, float y) {
    xCoords.add(pointCount, x);
    yCoords.add(pointCount, y);
    
    pointCount++;
  }
  
  
  public boolean checkHit(float x, float y) {
    return false;
  }
  
  
  public void setSelected(boolean selected) {
    isSelected = selected;
  }
  
  
  public void setShapeWeight(int newWeight) {
    lineWeight = newWeight;
  }
  
  
  public void setShapeColor(color newColor) {
    lineColor = newColor;
  }
  
  
  public void addLastPoint(float x, float y) {
    
  }
  
  
  public void drawShape() {
    float firstX = xCoords.get(0);
    float firstY = yCoords.get(0);
    
    if (pointCount > 1) {

      fill(lineColor);
      strokeWeight(lineWeight);
    
      for (int i = 1; i < pointCount; i++) {
        float xCoord = xCoords.get(i);
        float yCoord = yCoords.get(i);
        line(firstX, firstY, xCoord, yCoord); 
        
        firstX = xCoord;
        firstY = yCoord;
      }
      
    }
  }
}
