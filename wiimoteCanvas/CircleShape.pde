public class CircleShape extends AbstractPolygonShape {
  
  float x, y, radius;
  
  public CircleShape(float newX, float newY, float newRadius) {
    x = newX;
    y = newY;
    radius = newRadius;
    isSelected = false;
  } 
 
  public void drawShape() {
    int weight;
    color strokeColor;
      
        if (isSelected || isHoverSelected) {
//          pushMatrix();
//          translate(getShapeCenterX(), getShapeCenterY());
//          rotate(getRotationAngle());
//          scale(getScale());
//          fill(fillColor);
//          stroke(255);
//          strokeWeight(lineWidth + 10);
//          ellipse(-getShapeCenterX(), -getShapeCenterY(), radius, radius);
//          popMatrix();
          weight = lineWidth + 10;
          strokeColor = color(255);
        } else {
          weight = lineWidth;
          strokeColor = color(fillColor);
        }

        pushMatrix();
        translate(getShapeCenterX(), getShapeCenterY());
        rotate(getRotationAngle());
        scale(getScale());
        fill(fillColor);
        stroke(strokeColor);
        strokeWeight(weight);
        ellipse(-getShapeCenterX(), -getShapeCenterY(), radius, radius);
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
