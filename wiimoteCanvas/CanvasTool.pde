abstract class CanvasTool {
  
  int iconW = 100;
  int iconH = 100;
  int iconCorner = 7;
  
  int selectedWeight = 4;
  int normalWeight = 1;
  
  boolean isSelected = false;
  
  color bgColor;
  
  public abstract color getIconColor();
  public abstract boolean wasClicked(int clickX, int clickY);
  public abstract void drawIcon();
  
  public void setSelected() {
    isSelected = !isSelected;
  }
  
  public void selectTool() {
    isSelected = true;
  }
  
  public void deselectTool() {
    isSelected = false;
  }
  
}
