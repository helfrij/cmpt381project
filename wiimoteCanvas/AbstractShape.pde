abstract class AbstractShape {
  
  int lineWidth;
  color lineColor;
  boolean isSelected;
  boolean isHoverSelected;
  boolean isDrawn;
  float rotationAngle;
  int clickBuffer = 15;
  
  public abstract void addPoint(float xPos, float yPos);
  public abstract void drawShape();
  public abstract boolean checkHit(float x, float y);
  public abstract void setRotationAngle(float newAngle);

  
  
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
  
  
  public void setLineColor(color newColor) {
    lineColor = newColor; 
  }
  
  
  public void hideShape() {
    isDrawn = false;
  }
  
  
  public void hoverSelect(boolean shapeHit) {
    if (!isSelected) {
      setHoverSelected(shapeHit);
    }
  }
  
  
  public float getRotationAngle() {
    return rotationAngle;
  }
  
  
  
}
