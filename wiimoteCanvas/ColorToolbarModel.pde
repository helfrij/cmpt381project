public class ColorToolbarModel extends AbstractToolbarModel {
//  
//  private float canvasHeight, canvasWidth;
//  
//  private float toolbarX, toolbarY;
//  private float toolbarW, toolbarH;
//  private boolean toolbarSelected;
//  private boolean toolbarMoving;
//  private float xOffset, yOffset;
//  private color toolbarColor;
//  
//  private int selectedWeight = 4;
//  private int normalWeight = 2;
//  private int hoverWeight = 4;
//  private int toolbarWeight;
//  
//  private float iconX, iconY, iconSize;
//  private float iconCushion;
  
  private int toolCount = 0;
  
  private ArrayList<AbstractTool> tools;
  private AbstractTool selectedTool;
  
  private float initX, initY;
  
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
    
    toolbarX = canvasW - 10;
    toolbarY = canvasH/2 - toolbarH/2;

    xOffset = 0.0;
    yOffset = 0.0;
    
    setToolbarSelected(false);
    setToolbarMoving(false);
  }
  
  
  public void loadTools() {
    RedTool redTool = new RedTool();
    tools.add(redTool);
  }
  
  
}
