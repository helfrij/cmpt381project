public class SelectionBox {
  
  Point startPoint;
  Point endPoint;
  boolean isShown;
  boolean dimensionsSet;
  float boxW, boxH;
  
  
  public SelectionBox(float startX, float startY) {
    startPoint = new Point(startX, startY);
    endPoint = new Point(startX, startY);
    isShown = true;
    dimensionsSet = false;
  }
  
  
  public void hide() {
    isShown = false;
  }
  
  
  public void show() {
    isShown = true;
  }
  
  
  public boolean containsX(float xVal) {
    if (startPoint.getX() < endPoint.getX()) {
      if (xVal > startPoint.getX() && xVal < endPoint.getX()) {
        return true;
      }
    } else if (startPoint.getX() > endPoint.getX()) {
      if (xVal < startPoint.getX() && xVal > endPoint.getX()) {
        return true;
      }
    }
    
    return false;
  }
  
  
    public boolean containsY(float yVal) {
    if (startPoint.getY() < endPoint.getY()) {
      if (yVal > startPoint.getY() && yVal < endPoint.getY()) {
        return true;
      }
    } else if (startPoint.getY() > endPoint.getY()) {
      if (yVal < startPoint.getY() && yVal > endPoint.getY()) {
        return true;
      }
    }
    
    return false;
  }
  
  
  public void updateEndpoint(float newX, float newY) {
    endPoint.setX(newX);
    endPoint.setY(newY);
    
    boxW = abs(startPoint.getX() - endPoint.getX());
    boxH = abs(startPoint.getY() - startPoint.getY());
    
    dimensionsSet = true;
  }
  
  
  public void drawSelectionBox() {
    if (isShown && dimensionsSet) {
      noFill();
      stroke(0, 0, 0);
      strokeWeight(1);
      rect(startPoint.getX(), startPoint.getY(), boxW, boxH);
    }
  }
}
