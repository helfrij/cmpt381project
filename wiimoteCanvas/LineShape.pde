public class LineShape extends AbstractShape {
  
  private ArrayList<Point> points;
  private int clickBuffer;
  private float minX, maxX, minY, maxY;
    
  public LineShape() {
    points = new ArrayList<Point>();
    clickBuffer = 15;
    
    minX = 0;
    maxX = 0;
    minY = 0;
    maxY = 0;
    
    lineWidth = 2;
    lineColor = color(0, 0, 0);
    isSelected = false;
    isDrawn = true;
    isHoverSelected = false;
  }
  
  
  public void addPoint(float xPos, float yPos) {
    points.add(new Point(xPos, yPos));
    
    if (xPos < minX) {
      minX = xPos; 
    }
    
    if (xPos > maxX) {
      maxX = xPos; 
    }
    
    if (yPos < minY) {
      minY = yPos; 
    }
    
    if (yPos > maxY) {
      maxY = yPos; 
    }
  }
  
  
  public boolean checkHit(float x, float y) {
      
    if (x < (maxX + clickBuffer) && x > (minX - clickBuffer)) {
      if (y < (maxY + clickBuffer) && y > (maxY - clickBuffer)) {
        return true;
      }
    }
    
    return false;
  }
  
  
  public void drawShape() {
    
    if (isDrawn) {
      int pointCount = points.size();
    
      if (pointCount >= 2) {
        Point startPoint = points.get(0);
        Point endPoint = points.get(pointCount - 1);
      
        if (isSelected || isHoverSelected) {
          fill(255);
          stroke(255);
          strokeWeight(lineWidth + 10);
          line(startPoint.getX(), startPoint.getY(), endPoint.getX(), endPoint.getY());
        }

        fill(lineColor);
        stroke(lineColor);
        strokeWeight(lineWidth);
        line(startPoint.getX(), startPoint.getY(), endPoint.getX(), endPoint.getY());
      }
    }
  }
  
}
