public class ColorToolbarModel extends AbstractToolbarModel {
    
  public ArrayList<AbstractTool> tools;
  public AbstractTool selectedTool;
  
  public float initX, initY;
  
  int shapeColorIndex;
  int canvasColorIndex;
  int rVal, gVal, bVal;
  int[][] colours;
  int[][] canvasColors;
  
  public ColorToolbarModel(int w, int h) {
    canvasWidth = w;
    canvasHeight = h;
    
    iconSize = 100;
    iconCushion = 20;
    
    tools = new ArrayList<AbstractTool>();
    loadTools(); 
    
    toolbarH = iconCushion + (iconSize + iconCushion) * toolCount;
    toolbarW = iconSize + 2*iconCushion;
    toolbarColor = color(0, 0, 0, 255/2);
    
    toolbarX = canvasW - 10 - toolbarW;
    toolbarY = canvasH/2 - toolbarH/2;

    xOffset = 0.0;
    yOffset = 0.0;
    
    setToolbarSelected(false);
//    setToolbarMoving(false);

    rVal = 0;
    gVal = 0;
    bVal = 0;

    int[] black = {0, 0, 0};
    int[] red = {255, 0, 0};
    int[] orange = {255, 165, 0};
    int[] yellow = {255, 255, 0};
    int[] green = {34, 139, 34};
    int[] blue = {0, 191, 255};
    int[] indigo = {75, 0, 130}; 
    int[] violet = {148, 0, 211};
    
    shapeColorIndex = 0;
    canvasColorIndex = 0;
    
    colours = new int[8][3];
    colours[0] = black;
    colours[1] = red;
    colours[2] = orange;
    colours[3] = yellow;
    colours[4] = green;
    colours[5] = blue;
    colours[6] = indigo;
    colours[7] = violet;  
    
    int[] grey = {220, 220, 220};
    int[] white = {255, 255, 255};
    int[] pink = {255, 182, 193};
    int[] thistle = {255, 225, 255};
    int[] lavender = {230, 230, 250};
    int[] lightBlue = {191, 239, 255};
    int[] lightGreen = {193, 255, 193};
    int[] lightYellow = {238, 238, 209};
    
    canvasColors = new int[8][3];
    canvasColors[0] = grey;
    canvasColors[1] = white;
    canvasColors[2] = pink;
    canvasColors[3] = thistle;
    canvasColors[4] = lavender;
    canvasColors[5] = lightBlue;
    canvasColors[6] = lightGreen;
    canvasColors[7] = lightYellow;
    
    
  }
  
  
  public void loadTools() {
    RedTool redTool = new RedTool();
    tools.add(redTool);
    
    GreenTool greenTool = new GreenTool();
    tools.add(greenTool);
    
    BlueTool blueTool = new BlueTool();
    tools.add(blueTool);
  }
  
  
  public void drawIcons() {
    int iconNum = tools.size();
    for (int i = 0; i < iconNum; i++) {
      iconX = toolbarX + iconCushion;
      iconY = toolbarY + iconCushion + (iconSize + iconCushion) * i;
      tools.get(i).drawIcon(iconX, iconY, iconSize);
    }
  }
  
  
  public void setToolbarSelected(boolean selected) {
    isSelected = selected;
  }
  
  
  public boolean toolbarHit(float x, float y) {
    return x > toolbarX && x < toolbarX + toolbarW && y > toolbarY && y < toolbarY + toolbarH;
  }
  
  
  public boolean iconsHit(float x, float y) {
    
    for(AbstractTool tool : tools) {
      if (tool.iconHit(x, y)) {
        return true;
      }
    } 
    
    return false;
  }
  
  
  public boolean toolbarBorderHit(float x, float y) {
    if (toolbarHit(x, y) && !iconsHit(x, y)) {
      return true;
    }
    
    return false;
  }
  
  
  public void iconHoverCheck(float cursorX, float cursorY) {
    // intentionally blank.
  }
  
  
  public void pressCheck(float pressX, float pressY) {
    // intentionally blank.
  }
  
  
  public void clickCheck(float clickX, float clickY) {
    // intentionally blank.
  }
  
  
  public void dragCheck(float dragX, float dragY) {
    // intentionally blank.
  }
  
  
  public void release(float lastX, float lastY) {
   // intentionally blank. 
  }
  
  
  public boolean selectedToolExists() {
    return true;
  }
  
  
  public AbstractTool getSelectedTool() {
    return null;
  }
  
  
  public void setSelectedTool(AbstractTool tool) {
    // intentionally blank.
  }
  
  public color switchLineColor() {
    shapeColorIndex++;
    
    if (shapeColorIndex > colours.length - 1) {
      shapeColorIndex = 0;
    }
    
    rVal = colours[shapeColorIndex][0];
    gVal = colours[shapeColorIndex][1];
    bVal = colours[shapeColorIndex][2];
    
    color newColor = color(rVal, gVal, bVal);
    
    return newColor;

  }
  
  
  public color switchCanvasColor() {
    canvasColorIndex++;
    
    if (canvasColorIndex > canvasColors.length - 1) {
      canvasColorIndex = 0;
    }
    
    rVal = canvasColors[canvasColorIndex][0];
    gVal = canvasColors[canvasColorIndex][1];
    bVal = canvasColors[canvasColorIndex][2];
    
    color newColor = color(rVal, gVal, bVal);
    
    return newColor;
  }
  
  
  public void decreaseR() {
    rVal--;
    
    if (rVal < 0) {
      rVal = 0;
    }
  }
  
  
  public void increaseR() {
    rVal++;
    
    if (rVal > 255) {
      rVal = 255; 
    }
  }
  
  
  public void decreaseG() {
    gVal--;
    
    if (gVal < 0) {
      gVal = 0;
    }
  }
  
  
  public void increaseG() {
    gVal++;
    
    if (gVal > 255) {
      gVal = 255;
    }
  }
  
  
  public void decreaseB() {
    bVal--;
    
    if (bVal < 0) {
      bVal = 0;
    }
  }
  
  
  public void increaseB() {
    bVal++;
    
    if (bVal > 255) {
      bVal = 255;
    }
  }
  
  
}
