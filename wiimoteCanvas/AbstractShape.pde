abstract class AbstractShape {
  
  int lineWidth = 2;
  int lineWidthMin = 1;
  int lineWidthMax = 5;
  boolean isSelected;
  boolean isHoverSelected;
  boolean isDrawn;
  float scale;
  float scaleMax = 3.0;
  float scaleMin = 0.1;
  float rotationAngle;
  int clickBuffer = 15;
  
  public abstract void addPoint(float xPos, float yPos);
  public abstract void drawShape();
  public abstract boolean checkHit(float x, float y);
  public abstract float getMinX();
  public abstract float getMaxX();
  public abstract float getMinY();
  public abstract float getMaxY();
  public abstract float getShapeCenterX();
  public abstract float getShapeCenterY();
  public abstract void translateX(float dx);
  public abstract void translateY(float dy);
  public abstract void setShapeColor(color newColor);
  
  
  public boolean isSelected() {
    return isSelected;
  }
  
  public boolean isHoverSelected() {
    return isHoverSelected;
  }
  
  
  public void setSelected(boolean selected) {
    isSelected = selected; 
  }
  
  
  public void setHoverSelected(boolean hoverSelected) {
    isHoverSelected = hoverSelected;
  }
  
  
  public void setLineWidth(int newWidth) {
    lineWidth = newWidth; 
  }
  
  
  public void hideShape() {
    isDrawn = false;
  }
  
  
  public void hoverSelect(boolean shapeHit) {
    if (!isSelected) {
      setHoverSelected(shapeHit);
    }
  }
  
  
  public void setRotationAngle(float newAngle) {
    rotationAngle = newAngle;
  }
  
  
  public float getRotationAngle() {
    return rotationAngle;
  }
  
  
  public void setScale(float newScale) {
    if (newScale >= scaleMin && newScale <= scaleMax) {
      scale = newScale;
    }
  }
  
  
  public float getScale() {
    return scale;
  }
  
  
  
}
