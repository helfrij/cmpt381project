public class SelectionBox {
  
  Point startPoint;
  Point endPoint;
  boolean isShown;
  
  
  public SelectionBox(float startX, float startY) {
    startPoint = new Point(startX, startY);
    endPoint = new Point(startX, startY);
    isShown = true;
  }
  
  
  public void hide() {
    isShown = false;
  }
  
  
  public void show() {
    isShown = true;
  }
  
  
  public void setStartPoint(float startX, float startY) {
    startPoint.setX(startX);
    startPoint.setY(startY);
    
    endPoint.setX(startX);
    endPoint.setY(startY);
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
  }
  
  
  public void drawSelectionBox() {
    if (isShown) {
      noFill();
      stroke(0, 0, 0);
      strokeWeight(1);
      rectMode(CORNERS);
      rect(startPoint.getX(), startPoint.getY(), endPoint.getX(), endPoint.getY());
      rectMode(CORNER);
    }
  }
}
