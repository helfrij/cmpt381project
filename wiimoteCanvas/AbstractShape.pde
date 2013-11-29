abstract class AbstractShape {
  
  int lineWidth;
  color lineColor;
  boolean isSelected;
  
//  public abstract void addFirstPoint(float xPos, float yPos);
  public abstract void addPoint(float xPos, float yPos);
//  public abstract void addLastPoint(float xPos, float yPos);
  public abstract void drawShape();
  public abstract boolean checkHit(float x, float y);
  
  
  public boolean isSelected() {
    return isSelected;
  }
  
  
  public void setSelected(boolean selected) {
    isSelected = selected; 
  }
  
  
  public void setLineWidth(int newWidth) {
    lineWidth = newWidth; 
  }
  
  
  public void setLineColor(color newColor) {
    lineColor = newColor; 
  }
  
}
