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
  
  
  public void setRotationAngle(float newAngle) {
    
  }
  
  
  public void drawShape() {
    if (isDrawn) {
      int pointsCount = points.size();

      if (isSelected || isHoverSelected) {
        noFill();
        stroke(255);
        strokeWeight(lineWidth + 10);
        strokeJoin(ROUND);
        beginShape();
        
        for (int i = 0; i < pointsCount; i++) {
          vertex(points.get(i).getX(), points.get(i).getY());
        }
        
        endShape();
      }
      
      noFill();
      stroke(lineColor);
      strokeWeight(lineWidth);
      strokeJoin(ROUND);
      beginShape();
      
      for (int i = 0; i < pointsCount; i++) {
        vertex(points.get(i).getX(), points.get(i).getY());
      }
      
      endShape();
    }
  }
}
