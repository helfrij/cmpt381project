public abstract class AbstractToolbarModel {
  
  private float canvasHeight, canvasWidth;
  
  private float toolbarX, toolbarY;
  private float toolbarW, toolbarH;
  private boolean toolbarSelected;
  private boolean toolbarMoving;
  private float xOffset, yOffset;
  private color toolbarColor;
  
  private int selectedWeight = 4;
  private int normalWeight = 2;
  private int hoverWeight = 4;
  private int toolbarWeight;
  
  private float iconX, iconY, iconSize;
  private float iconCushion;
  
  private int toolCount = 0;
  
  private ArrayList<AbstractTool> tools;
  private AbstractTool selectedTool;
  
  private float initX, initY;
  
  
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
  
  
  public abstract void loadTools();
  
  
  public void setToolbarSelected(boolean isSelected) {
    toolbarSelected = isSelected;
    
    if (toolbarSelected) {
      toolbarWeight = selectedWeight; 
    } else {
      toolbarWeight = normalWeight;
    }
  }
  
  
  public boolean selectedToolExists() {
    if (selectedTool == null) {
      return false;
    } else {
      return true;
    } 
  }
  
  
  public AbstractTool getSelectedTool() {
    return selectedTool; 
  }
  
  
  public boolean canvasHit(float x, float y) {
    if (!toolbarHit(x, y) && !iconsHit(x, y)) {
      return true;
    } else {
      return false;
    }
  }
  
  
  private void setSelectedTool(AbstractTool tool) {
    // deselect the old selected tool, if it exists.
    if (selectedTool != null) {
      selectedTool.setSelected(false);
    }
    
    // set the new selected tool.
    if (tool != null) {
      selectedTool = tool;
      tool.setSelected(true); 
    }
  }
  
  
  public boolean toolbarHit(float x, float y) {
    // check to see if the click occurred within the bounds of the toolbar rectangle.
    if (x > toolbarX && x < toolbarX + toolbarW && y > toolbarY && y < toolbarY + toolbarH) {
      if (iconsHit(x, y)) {
        return false; // click was in-bounds, but an icon was hit.
      } else {
        return true; // click was in-bounds and no icons were hit.
      }
    } else {
      return false; // click was out of bounds.
    }
  }
  
  
  public boolean iconsHit(float x, float y) {
    
    for(AbstractTool tool : tools) {
      if (tool.iconHit(x, y)) {
        return true;
      }
    } 
    
    return false;
  }
  
  
  public void shiftCoords(float newX, float newY) {
    if (toolbarSelected && toolbarMoving) {
      toolbarX = newX;
      toolbarY = newY;
    } 
  }
  
  
  public void drawIcons() {
    int count = 0;
    for (AbstractTool tool : tools) {
      iconX = toolbarX + iconCushion;
      iconY = toolbarY + iconCushion + (iconSize + iconCushion) * count;
      tool.drawIcon(iconX, iconY, iconSize);
      count++;
    }
  }
  
  
  public void iconHoverCheck(float cursorX, float cursorY) {
    for (AbstractTool tool: tools) {
      tool.iconHoverCheck(cursorX, cursorY);
    }
  }
  
  
  public void clickCheck(float clickX, float clickY) {
    // if the toolbar (and only the toolbar) was hit by the click, make toolbar selected.
    if (toolbarHit(clickX, clickY)) {
      setToolbarSelected(true);
    } else {
      setToolbarSelected(false);
    }
    
    // if one of the icons was hit by the click, make that one the selected tool.
    if (iconsHit(clickX, clickY)) {
      for (AbstractTool tool : tools) {
        if (tool.iconHit(clickX, clickY)) {
          setSelectedTool(tool);
          break;
        } 
      }
    }
  }
  
  
  public void pressCheck(float pressX, float pressY) {
    // if the toolbar was clicked (and not an icon) set toolbar as selected and get ready to move the toolbar.
    if (toolbarHit(pressX, pressY)) {
      setToolbarSelected(true);
      xOffset = pressX - toolbarX;
      yOffset = pressY - toolbarY;
      
    // else, make sure the toolbar is deselected.
    } else {
      setToolbarSelected(false);
      xOffset = 0.0;
      yOffset = 0.0;
      
    }
  }
  
  
  public void dragCheck(float xPos, float yPos) {
//    // if the toolbar is selected, the operation the user will perform is moving the toolbar.
//    if (toolbarSelected) {
//      setToolbarMoving(true);
//      float newX = xPos - xOffset;
//      float newY = yPos - yOffset;
//      shiftCoords(newX, newY);
//    }
  }
  
  
  public void release(float xPos, float yPos) {
    setToolbarSelected(false);
//    setToolbarMoving(false); 
    xOffset = 0.0;
    yOffset = 0.0;
  }
  
}
