public class CircleShape extends AbstractPolygonShape {
  
  float x, y, radius;
  
  public CircleShape(float newX, float newY, float newRadius) {
    x = newX;
    y = newY;
    radius = newRadius;
    isSelected = false;
    isDrawn = true;
  } 
 
  public void drawShape() {
      int weight;
      color strokeColor;
      
        if (isSelected || isHoverSelected) {
          weight = 5;
          strokeColor = color(255);
          
        } else {
          
          weight = 0;
          strokeColor = color(0);
        }

        pushMatrix();
        translate(getShapeCenterX(), getShapeCenterY());
        rotate(getRotationAngle());
        scale(getScale());
        fill(fillColor);
        
        if (weight == 0 || strokeColor == color(0)) {
          noStroke();
        } else {
          stroke(strokeColor);
          strokeWeight(weight);
        }
        
//        ellipse(-getShapeCenterX(), -getShapeCenterY(), radius, radius);
        ellipse(0, 0, radius, radius);
        popMatrix();

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
