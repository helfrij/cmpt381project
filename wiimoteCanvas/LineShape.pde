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
      
      print("Start : " + startPoint.getX() + ", " + startPoint.getY() + "\n");
      print("End : " + endPoint.getX() + ", " + endPoint.getY() + "\n");
      
      float slope = 0.0;
      float lineY = 0.0;
      
      // first, find out if x is between the startPoint and endPoint x values.
      if (startPoint.getX() <= endPoint.getX()) {
        if (x >= startPoint.getX() && x <= endPoint.getX()) {
          slope = (endPoint.getY() - startPoint.getY()) / (endPoint.getX() - startPoint.getX());
          lineY = startPoint.getY() + slope * (x - startPoint.getX());
        }
        
      } else if (startPoint.getX() > endPoint.getX()) {
        if (x <= startPoint.getX() && x >= endPoint.getX()) {
          slope = (startPoint.getY() - endPoint.getY()) / (startPoint.getX() - endPoint.getX());
          lineY = endPoint.getY() + slope * (x - endPoint.getY());
        }
        
      } else {
        return false;
      }
      
      print("Slope : " + slope + "\n");
      print("Hover : " + x + ", " + y + "\n");
      print("Cursor : " + mouseX + ", " + mouseY + "\n");
      print("Line Y : " + lineY + "\n\n\n");
//      print("Line difference : " + (mouseX - x) + ", " + (mouseY - lineY) + "\n\n\n");
      
      // if the given y value is within clickBuffer amount of the line y, the line has been hit!
      if (y > lineY - clickBuffer && y < lineY + clickBuffer) {
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
