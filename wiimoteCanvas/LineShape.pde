public class LineShape extends AbstractShape {
  
  FloatList xCoords;
  FloatList yCoords;
  int pointCount;
  
  int lineWeight;
  color lineColor;
  
  
  public LineShape() {
    pointCount = 0;
    isSelected = false;
  }
  
  
  public void addPoint(float xPos, float yPos) {
   // because a straight line only needs two points, we ignore intermediate points that would be added here. 
   if (pointCount == 0) {
     xCoords.add(pointCount, xPos);
     yCoords.add(pointCount, yPos);
     pointCount++;
   }
  }
  
  
  public void addLastPoint(float xPos, float yPos) {
    if (pointCount == 1) {
      xCoords.add(pointCount, xPos);
      yCoords.add(pointCount, yPos); 
      pointCount++;
    }
  }
  
  
  public boolean checkHit(float x, float y) {
    return false;
  }
  
  
  public void setSelected(boolean selected) {
    isSelected = selected;
  }
  
  
  public void drawShape() {
    
    float startX = xCoords.get(0);
    float startY = yCoords.get(0);
    float endX = xCoords.get(1);
    float endY = yCoords.get(1);
    
    fill(lineColor);
    strokeWeight(lineWeight);
    line(startX, startY, endX, endY);
  }
  
}
