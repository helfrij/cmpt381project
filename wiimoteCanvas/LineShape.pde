public class LineShape extends AbstractShape {
  
  private ArrayList<Point> points;
  private int clickBuffer;
    
  public LineShape() {
    points = new ArrayList<Point>();
    clickBuffer = 10;
    
    lineWidth = 2;
    lineColor = color(0, 0, 0);
    isSelected = false;
    isDrawn = true;
  }
  
  
  public void addPoint(float xPos, float yPos) {
    points.add(new Point(xPos, yPos));
  }
  
  
  public boolean checkHit(float x, float y) {
    for (Point point : points) {
      float pointX = point.getX();
      float pointY = point.getY();
      
      if (pointX < (x + clickBuffer) && pointX > (x - clickBuffer)) {
        if (pointY < (y + clickBuffer) && pointY > (y - clickBuffer)) {
          return true;
        }
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
