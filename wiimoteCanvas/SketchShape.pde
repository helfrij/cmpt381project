public class SketchShape extends AbstractLineShape {
  
  private ArrayList<Point> points;
  
  public SketchShape() {
    isSelected = false;
    lineWidth = 2;
    lineColor = color(0, 0, 0);
    isDrawn = true;
    isHoverSelected = false;
    points = new ArrayList<Point>();
    rotationAngle = 0;
    scale = 1.0;
  }
  
  
  public void addPoint(float x, float y) {
    points.add(new Point(x, y));
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

      if (isSelected || isHoverSelected) {
        pushMatrix();
        translate(getShapeCenterX(), getShapeCenterY());
        rotate(getRotationAngle());
        scale(getScale());
        noFill();
        stroke(255);
        strokeWeight(lineWidth + 10);
        strokeJoin(ROUND);
        beginShape();
        
        for (int i = 0; i < pointsCount; i++) {
          vertex(-getShapeCenterX() + points.get(i).getX(), -getShapeCenterY() + points.get(i).getY());
        }
        
        endShape();
        popMatrix();
      }
      
      pushMatrix();
      translate(getShapeCenterX(), getShapeCenterY());
      rotate(getRotationAngle());
      scale(getScale());
      noFill();
      stroke(lineColor);
      strokeWeight(lineWidth);
      strokeJoin(ROUND);
      beginShape();
      
      for (int i = 0; i < pointsCount; i++) {
        vertex(-getShapeCenterX() + points.get(i).getX(), -getShapeCenterY() + points.get(i).getY());
      }
      
      endShape();
      popMatrix();
    }
  }
}
