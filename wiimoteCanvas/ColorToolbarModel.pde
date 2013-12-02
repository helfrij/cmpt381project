//public class ColorToolbarModel extends AbstractToolbarModel {
//    
//  public ArrayList<AbstractTool> tools;
//  public AbstractTool selectedTool;
//  
//  public float initX, initY;
//  
//  int colorIndex;
//  int rVal, gVal, bVal;
//  int[][] colours;
//  
//  public ColorToolbarModel(int w, int h) {
//    canvasWidth = w;
//    canvasHeight = h;
//    
//    iconSize = 100;
//    iconCushion = 20;
//    
//    tools = new ArrayList<AbstractTool>();
//    loadTools(); 
//    
//    toolbarH = iconCushion + (iconSize + iconCushion) * toolCount;
//    toolbarW = iconSize + 2*iconCushion;
//    toolbarColor = color(0, 0, 0, 255/2);
//    
//    toolbarX = canvasW - 10 - toolbarW;
//    toolbarY = canvasH/2 - toolbarH/2;
//
//    xOffset = 0.0;
//    yOffset = 0.0;
//    
//    setToolbarSelected(false);
////    setToolbarMoving(false);
//
//    rVal = 0;
//    gVal = 0;
//    bVal = 0;
//
//    int[] black = {0, 0, 0};
//    int[] red = {255, 0, 0};
//    int[] orange = {255, 165, 0};
//    int[] yellow = {255, 255, 0};
//    int[] green = {34, 139, 34};
//    int[] blue = {0, 191, 255};
//    int[] indigo = {75, 0, 130}; 
//    int[] violet = {148, 0, 211};
//    
//    colorIndex = 0;
//    colours = new int[8][3];
//    colours[0] = black;
//    colours[1] = red;
//    colours[2] = orange;
//    colours[3] = yellow;
//    colours[4] = green;
//    colours[5] = blue;
//    colours[6] = indigo;
//    colours[7] = violet;  
//  }
//  
//  
//  public void loadTools() {
//    RedTool redTool = new RedTool();
//    tools.add(redTool);
//    
//    GreenTool greenTool = new GreenTool();
//    tools.add(greenTool);
//    
//    BlueTool blueTool = new BlueTool();
//    tools.add(blueTool);
//  }
//  
//  
//  public void drawIcons() {
//    int iconNum = tools.size();
//    for (int i = 0; i < iconNum; i++) {
//      iconX = toolbarX + iconCushion;
//      iconY = toolbarY + iconCushion + (iconSize + iconCushion) * i;
//      tools.get(i).drawIcon(iconX, iconY, iconSize);
//    }
//  }
//  
//  
//  public boolean iconsHit(float x, float y) {
//    
//    for(AbstractTool tool : tools) {
//      if (tool.iconHit(x, y)) {
//        return true;
//      }
//    } 
//    
//    return false;
//  }
//  
//  
//  public void iconHoverCheck(float cursorX, float cursorY) {
//    
//  }
//  
//  
//  public void setSelectedTool(AbstractTool tool) {
//    
//  }
//  
//  public color switchLineColor() {
//    colorIndex++;
//    
//    if (colorIndex > colours.length - 1) {
//      colorIndex = 0;
//    }
//    
//    rVal = colours[colorIndex][0];
//    gVal = colours[colorIndex][1];
//    bVal = colours[colorIndex][2];
//    
//    color newColor = color(rVal, gVal, bVal);
//    
//    return newColor;
//    
////    for (AbstractShape shape : selectedShapes) {
////      shape.setLineColor( newColor );
////    }
//  }
//  
//  
//  public void decreaseR() {
//    rVal--;
//    
//    if (rVal < 0) {
//      rVal = 0;
//    }
//  }
//  
//  
//  public void increaseR() {
//    rVal++;
//    
//    if (rVal > 255) {
//      rVal = 255; 
//    }
//  }
//  
//  
//  public void decreaseG() {
//    gVal--;
//    
//    if (gVal < 0) {
//      gVal = 0;
//    }
//  }
//  
//  
//  public void increaseG() {
//    gVal++;
//    
//    if (gVal > 255) {
//      gVal = 255;
//    }
//  }
//  
//  
//  public void decreaseB() {
//    bVal--;
//    
//    if (bVal < 0) {
//      bVal = 0;
//    }
//  }
//  
//  
//  public void increaseB() {
//    bVal++;
//    
//    if (bVal > 255) {
//      bVal = 255;
//    }
//  }
//  
//  
//}
