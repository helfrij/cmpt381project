abstract class AbstractTool {
  
  float iconX, iconY, iconSize;
  color iconColor;
  
  int selectedOpacity = 255;
  int hoverOpacity = 255;
  int normalOpacity = 255/2;
  int opacity = normalOpacity;
  
  int selectedWeight = 4;
  int hoverWeight = 4;
  int normalWeight = 2;
  int weight = normalWeight;
  
  boolean isSelected = false;

  public abstract void drawIcon(float xPos, float yPos, float size);
  public abstract AbstractShape createCanvasShape();
  
  public color getIconColor() {
    return iconColor; 
  }
  
  public void setSelected(boolean selected) {
    isSelected = selected;
    
    if (isSelected == true) {
      weight = selectedWeight; 
      opacity = selectedOpacity;
    } else {
      weight = normalWeight; 
      opacity = normalOpacity;
    }
  }
  
  
  public boolean iconHit(float xVal, float yVal) {
    if (xVal < iconX + iconSize && xVal > iconX && yVal < iconY + iconSize && yVal > iconY) {
      return true; 
    } else {
      return false; 
    }
  }
  
  
  public void iconHoverCheck(float cursorX, float cursorY) {
    if (iconHit(cursorX, cursorY)) {
      weight = hoverWeight;
      opacity = hoverOpacity;
    } else if (isSelected) {
      weight = selectedWeight; 
      opacity = selectedOpacity;
    } else {
      weight = normalWeight; 
      opacity = normalOpacity;
    }
  }
  
}
