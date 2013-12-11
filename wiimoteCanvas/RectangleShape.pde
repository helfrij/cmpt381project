public class RectangleShape extends AbstractPolygonShape {
  
  float x, y, w, h;
  
  public RectangleShape(float newX, float newY, float newWidth, float newHeight) {
    x = newX;
    y = newY;
    w = newWidth;
    h = newHeight;
  } 
  
//  public void addPoint(float newX, float newY) {
//    // intentionally empty.
//  }
 
  public void drawShape() {
    fill(0);
    stroke(0);
    strokeWeight(1);
    rect(x, y, w, h); 
  }
 
  public float getMinX() {
    if (x < x + w) {
      return x;
    }
    
    return x + w;
  }
  
  public float getMaxX() {
    if (x > x + w) {
      return x;
    }
    
    return x + w;
  }
 
  public float getMinY() {
    if (y < y + h) {
      return y;
    }
    
    return y + h;
  }
  
  public float getMaxY() {
    if (y > y + h) {
      return y;
    }
    
    return y + h;
  }
  
  public float getShapeCenterX() {
    return x + w/2;
  }
  
  public float getShapeCenterY() {
    return y + h/2;
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
    if (xPos < x + w && xPos > x - w && yPos < y + h && yPos > y - h) {
      return true;
    }
    
    return false;
  }
}
