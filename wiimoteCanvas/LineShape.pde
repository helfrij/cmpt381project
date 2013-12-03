public class LineShape extends AbstractLineShape {
  
  private ArrayList<Point> points;
  private Point startPoint;
  private Point endPoint;
    
  public LineShape() {
    points = new ArrayList<Point>();
    
    lineWidth = 2;
    lineColor = color(0, 0, 0);
    isSelected = false;
    isDrawn = true;
    isHoverSelected = false;
    rotationAngle = 0;
  }
  
  
  public void addPoint(float xPos, float yPos) {
    if (points.size() == 0) {
      startPoint = new Point(xPos, yPos);
      points.add(startPoint);
      
    } else {
      points.add(new Point(xPos, yPos));
    }
  }
  
  
  public boolean checkHit(float x, float y) {
    int pointCount = points.size();
    
    if (pointCount >= 2) {
      endPoint = points.get(pointCount - 1);
      float slope = 0.0;
      float lineY = 0.0;
      
      // first, find out if x is between the startPoint and endPoint x values.
      if (startPoint.getX() <= endPoint.getX()) {
        if (x >= startPoint.getX() && x <= endPoint.getX()) {
          slope = (endPoint.getY() - startPoint.getY()) / (endPoint.getX() - startPoint.getX());
          lineY = startPoint.getY() + slope * x;
        }
      } else if (startPoint.getX() > endPoint.getX()) {
        if (x <= startPoint.getX() && x >= endPoint.getX()) {
          slope = (startPoint.getY() - endPoint.getY()) / (startPoint.getX() - endPoint.getX());
          lineY = endPoint.getY() + slope * x;
        }
      } else {
        return false;
      }
      
      // next, identify the y value of the line at the given x.
      print(lineY + "\n");
      print(y + "\n\n");
      
      // if the given y value is within clickBuffer amount of the line y, the line has been hit!
      if (y + clickBuffer > lineY && y - clickBuffer < lineY) {
        return true;
      }
    }
    
    return false;
  }
  
  
  public void setRotationAngle(float newAngle) {

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
