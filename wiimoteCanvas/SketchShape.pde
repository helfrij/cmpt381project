public class SketchShape extends AbstractShape {
  
  private ArrayList<Point> points;
  int clickBuffer;
  
  public SketchShape() {
    isSelected = false;
    lineWidth = 2;
    lineColor = color(0, 0, 0);
    isDrawn = true;
    isHoverSelected = false;
    points = new ArrayList<Point>();
    clickBuffer = 15;
  }
  
  
  public void addPoint(float x, float y) {
    points.add(new Point(x, y));
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
      int pointsCount = points.size();
    
      for (int i = 1; i < pointsCount; i++) {
        Point point1 = points.get(i-1);
        Point point2 = points.get(i);
        
        if (isSelected || isHoverSelected) {
          fill(255);
          stroke(255);
          strokeWeight(lineWidth + 10);
          line(point1.getX(), point1.getY(), point2.getX(), point2.getY());
        }
      
        fill(lineColor);
        stroke(lineColor);
        strokeWeight(lineWidth);
        line(point1.getX(), point1.getY(), point2.getX(), point2.getY());
      }
    }
  }
}
