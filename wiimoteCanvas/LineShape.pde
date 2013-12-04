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
    scale = 1.0;
  }
  
  
  public void addPoint(float xPos, float yPos) {
    if (points.size() == 0) {
      startPoint = new Point(xPos, yPos);
      points.add(startPoint);
      
    } else {
      points.add(new Point(xPos, yPos));
    }
  }
  
  
  public float getMinX() {
    int pointsNum = points.size();
    float minX = 0.0;
    
    if (pointsNum > 0) {
      minX = points.get(0).getX();
      
      for (int index = 1; index < pointsNum; index++) {
        float newX = points.get(index).getX();
        if (newX < minX) {
          minX = newX;
        }
      }
    }
    
    return minX;
  }
  
  
  public float getMaxX() {
    int pointsNum = points.size();
    float maxX = 0.0;
    
    if (pointsNum > 0) {
      maxX = points.get(0).getX();
      
      for (int index = 1; index < pointsNum; index++) {
        float newX = points.get(index).getX();
        if (newX > maxX) {
          maxX = newX;
        }
      }
    }
    
    return maxX;
  }
  
  
  public float getMinY() {
    int pointsNum = points.size();
    float minY = 0.0;
    
    if (pointsNum > 0) {
      minY = points.get(0).getY();
      
      for (int index = 1; index < pointsNum; index++) {
        float newY = points.get(index).getY();
        if (newY < minY) {
          minY = newY;
        }
      }
    }
    
    return minY;
  }
  
  
  public float getMaxY() {
    int pointsNum = points.size();
    float maxY = 0.0;
    
    if (pointsNum > 0) {
      maxY = points.get(0).getY();
      
      for (int index = 1; index < pointsNum; index++) {
        float newY = points.get(index).getY();
        if (newY > maxY) {
          maxY = newY;
        }
      }
    }
    
    return maxY;
  }
  
  
  public float getShapeCenterX() {
    float minX = getMinX();
    float maxX = getMaxX();
    float centerX = (minX + maxX) / 2;
    
    return centerX;
  }
  
  
  public float getShapeCenterY() {
    float minY = getMinY();
    float maxY = getMaxY();
    float centerY = (minY + maxY) / 2;
    
    return centerY;
  }
  
  
  public void translateX(float dx) {
    for (Point point : points) {
      float oldX = point.getX();
      float newX = oldX + dx;
      point.setX(newX);
    }
  }
  
  
  public void translateY(float dy) {
    for (Point point : points) {
      float oldY = point.getY();
      float newY = oldY + dy;
      point.setY(newY);
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
      
      // if the given y value is within clickBuffer amount of the line y, the line has been hit!
      if (y > lineY - clickBuffer && y < lineY + clickBuffer) {
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
          pushMatrix();
          translate(getShapeCenterX(), getShapeCenterY());
          rotate(getRotationAngle());
          scale(getScale());
          fill(255);
          stroke(255);
          strokeWeight(lineWidth + 10);
          line(-getShapeCenterX() + startPoint.getX(), -getShapeCenterY() + startPoint.getY(), -getShapeCenterX() + endPoint.getX(), -getShapeCenterY() + endPoint.getY());
          popMatrix();
        }

        pushMatrix();
        translate(getShapeCenterX(), getShapeCenterY());
        rotate(getRotationAngle());
        scale(getScale());
        fill(lineColor);
        stroke(lineColor);
        strokeWeight(lineWidth);
        line(-getShapeCenterX() + startPoint.getX(), -getShapeCenterY() + startPoint.getY(), -getShapeCenterX() + endPoint.getX(), -getShapeCenterY() + endPoint.getY());
        popMatrix();
      }
    }
  }
  
}
