public class CircleShape extends AbstractPolygonShape {
  
  float x, y, radius;
  
  public CircleShape(float newX, float newY, float newRadius) {
    x = newX;
    y = newY;
    radius = newRadius;
  } 
  
  public void addPoint(float newX, float newY) {
    // intentionally empty.
  }
 
  public void drawShape() {
    fill(0);
    stroke(0);
    strokeWeight(1);
    ellipse(x, y, radius, radius); 
  }
 
  public float getMinX() {
    return x - radius;
  }
  
  public float getMaxX() {
    return x + radius;
  }
 
  public float getMinY() {
    return y - radius;
  }
  
  public float getMaxY() {
    return y + radius;
  }
  
  public float getShapeCenterX() {
    return x;
  }
  
  public float getShapeCenterY() {
    return y;
  }

  public void translateX(float dx) {
    float oldX = x;
    x = oldX + dx;
  }

  public void translateY(float dy) {
    float oldY = y;
    y = oldY + dy;
  }
 
  public boolean checkHit(float xPos, float yPos) {
    if (xPos < x + radius && xPos > x - radius && yPos < y + radius && yPos > y - radius) {
      return true;
    }
    
    return false;
  }
}
