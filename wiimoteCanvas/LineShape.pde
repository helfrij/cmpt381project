public class LineShape extends AbstractShape {
  
  private ArrayList<Point> points;
    
  public LineShape() {
    points = new ArrayList<Point>();
    
    lineWidth = 2;
    lineColor = color(0, 0, 0);
    isSelected = false;
  }
  
  
  public void addPoint(float xPos, float yPos) {
    points.add(new Point(xPos, yPos));
  }
  
  
  public boolean checkHit(float x, float y) {
    return false;
  }
  
  
  public void drawShape() {
    int pointCount = points.size();
    
    if (pointCount >= 2) {
      Point startPoint = points.get(0);
      Point endPoint = points.get(pointCount - 1);
    
      fill(lineColor);
      stroke(lineColor);
      strokeWeight(lineWidth);
      line(startPoint.getX(), startPoint.getY(), endPoint.getX(), endPoint.getY());
    }
  }
  
}
