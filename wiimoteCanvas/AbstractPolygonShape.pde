public abstract class AbstractPolygonShape extends AbstractShape {
  
  color fillColor;
  
  public void setShapeColor(color newColor) {
    fillColor = newColor;
  }
  
  public void addPoint(float newX, float newY) {
    // intentionally empty.
  }
  
}
