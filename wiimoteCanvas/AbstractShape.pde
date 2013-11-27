abstract class AbstractShape {
 
  FloatList xCoords;
  FloatList yCoords;
  
  boolean isSelected;
  
  
  public abstract void addPoint(float xPos, float yPos);
  public abstract void addLastPoint(float xPos, float yPos);
  public abstract void drawShape();
  public abstract boolean checkHit(float x, float y);
  public abstract void setSelected(boolean isSelected);
  
  
  public boolean isSelected() {
    return isSelected;
  }
  
  
  public int pointsNumber() {
    return xCoords.size(); 
  }
  
}
