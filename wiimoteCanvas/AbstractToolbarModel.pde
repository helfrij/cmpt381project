public abstract class AbstractToolbarModel {
  
  float canvasHeight, canvasWidth;
  
  boolean isDrawn;
  
  float toolbarX, toolbarY;
  float toolbarW, toolbarH;
  boolean toolbarSelected;
  boolean toolbarMoving;
  float xOffset, yOffset;
  color toolbarColor;
  
  int selectedWeight = 4;
  int normalWeight = 2;
  int hoverWeight = 4;
  int toolbarWeight;
  
  float iconX, iconY;
  float iconSize = 100;
  float iconCushion;
  
  int toolCount = 0;
  
  AbstractTool selectedTool;
  
  public abstract void drawIcons();
  public abstract void loadTools();
  public abstract void setSelectedTool(AbstractTool tool);
  public abstract void setToolbarSelected(boolean isSelected);
  public abstract boolean selectedToolExists();
  public abstract AbstractTool getSelectedTool();
  
  public abstract boolean iconsHit(float x, float y);
  public abstract boolean toolbarBorderHit(float x, float y);
  public abstract boolean toolbarHit(float x, float y);

  public abstract void iconHoverCheck(float cursorX, float cursorY);
  public abstract void clickCheck(float clickX, float clickY);
  public abstract void pressCheck(float pressX, float pressY);
  public abstract void dragCheck(float dragX, float dragY);
  public abstract void release(float xPos, float yPos);
  
  
  public float getToolbarX() {
    return toolbarX; 
  }
  
  
  public float getToolbarY() {
    return toolbarY; 
  }
  
  
  public float getToolbarW() {
    return toolbarW; 
  }
  
  
  public float getToolbarH() {
    return toolbarH; 
  }
  
  
  public color getToolbarColor() {
    return toolbarColor; 
  }
  
  
  public int getToolbarWeight() {
    return toolbarWeight; 
  }
  
  
  public void showToolbar() {
    isDrawn = true;
  }
  
  
  public void hideToolbar() {
    isDrawn = false;
  }
  
  
  public boolean toolbarShown() {
    return isDrawn;
  }
  
  

  
  

  
  
//  public boolean toolbarHit(float x, float y) {
//    if (isDrawn) {
//      boolean wasHit = (x > toolbarX && x < toolbarX + toolbarW && y > toolbarY && y < toolbarY + toolbarH);
//      return wasHit;
//    }
//    
//    return false;
//  }
//  
//
//  
//  
//  public boolean toolbarBorderHit(float x, float y) {
//    // check to see if the click occurred within the bounds of the toolbar rectangle.
//    if (toolbarHit(x, y)) {
//      if (iconsHit(x, y)) {
//        return false; // click was in-bounds, but an icon was hit.
//      } else {
//        return true; // click was in-bounds and no icons were hit.
//      }
//    } else {
//      return false; // click was out of bounds.
//    }
//  }
  
  
  public void shiftCoords(float newX, float newY) {
    if (toolbarSelected && toolbarMoving) {
      toolbarX = newX;
      toolbarY = newY;
    } 
  }
  
    

  
}
