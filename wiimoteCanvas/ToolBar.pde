public class ToolBar {
  int toolbarX, toolbarY;
  int toolbarH, toolbarW;
  
  LineTool lineTool;
  ArrayList<CanvasTool> tools;
  
  public ToolBar(int xPos, int yPos, int w, int h) {
    
    toolbarX = xPos;
    toolbarY = yPos;
    toolbarW = w;
    toolbarH = h;
    
    // create list of available tools to display, add tools.
    tools = new ArrayList<CanvasTool>();
    lineTool = new LineTool(toolbarX + 5, toolbarY + 5);
    tools.add(lineTool);
    
  }
  
  public int getHeight() {
     return toolbarH; 
  }
 
  
  
  public void wasClicked(int x, int y) {
    for(CanvasTool c : tools) {
      if(c.wasClicked(x, y)) {
        c.setSelected();
      }
    }
  }
  
  public void drawToolBar() {
    
    fill(0);
    strokeWeight(1);
//    rect(canvasH/100, canvasH/100, toolbarW, toolbarH);
    rect(toolbarX, toolbarY, toolbarW, toolbarH);
    
    for (CanvasTool tool : tools) {
      tool.drawIcon();
    }
    
  }
  
}
  
  
