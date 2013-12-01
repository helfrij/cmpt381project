public class Circle {
  
  float x, y, radius;
  
  public Circle(float newX, float newY, float newRadius) {
    x = newX;
    y = newY;
    radius = newRadius;
  } 
 
  public void drawShape() {
    ellipse(x, y, radius, radius); 
  }
 
  public float getX() {
    return x;
  }
 
  public float getY() {
    return y;
  }

  public void setX(float newX) {
   x = newX;
  }

  public void setY(float newY) {
   y = newY;
  }

  public void setSelected() {
  }
 
  public boolean checkHit(float x, float y) {
    return true;
  }
}
