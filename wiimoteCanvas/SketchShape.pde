public class SketchShape extends AbstractShape {
  
  private ArrayList<Point> points;
  
  public SketchShape(float firstX, float firstY) {
    isSelected = false;
  }
  
  
  public void addPoint(float x, float y) {
    points.add(new Point(x, y));
  }
  
  
  public boolean checkHit(float x, float y) {
    return false;
  }
  
  
  public void drawShape() {

  }
}
