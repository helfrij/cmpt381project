public class ColorToolbar extends AbstractToolbar {
  
    int rVal, gVal, bVal;
    
    // create a list of colors to select from for the shapes.
    int colorIndex;
    int[][] colours;
 
  
  private ColorToolbarModel toolbarModel;
  
  public ColorToolbar(int w, int h) {
    canvasWidth = w;
    canvasHeight = h;
    
    isShown = false;
    
    toolbarModel = new ColorToolbarModel(canvasWidth, canvasHeight);
  }
  
  
  public void drawToolbar() {
    if (isShown) {
      float x = toolbarModel.getToolbarX();
      float y = toolbarModel.getToolbarY();
      float w = toolbarModel.getToolbarW();
      float h = toolbarModel.getToolbarH();
    
      fill(toolbarModel.getToolbarColor());
      stroke(255);
      strokeWeight(toolbarModel.getToolbarWeight());
      rect(x, y, w, h, 7);
    }
  }
  
  
  public void hideToolbar() {
    
  }
  
  
  public void showToolbar() {
    
  }
  
  
  public boolean toolbarHit(float hitX, float hitY) {
    return toolbarModel.toolbarHit(hitX, hitY);
  }
  
  
  public boolean iconsHit(float hitX, float hitY) {
    return toolbarModel.iconsHit(hitX, hitY);
  }
  
  
  public boolean toolbarBorderHit(float hitX, float hitY) {
    if (toolbarHit(hitX, hitY) && !iconsHit(hitX, hitY)) {
      return true;
    }
    
    return false;
  }
  
  
  public void pressCheck(float pressX, float pressY) {
    toolbarModel.pressCheck(pressX, pressY);
  }
  
  
  public void clickCheck(float clickX, float clickY) {
    toolbarModel.clickCheck(clickX, clickY);
  }
  
  
  public void hoverCheck(float hoverX, float hoverY) {
    toolbarModel.iconHoverCheck(hoverX, hoverY);
  }
  
  
  public void dragCheck(float dragX, float dragY) {
    
  }
  
  
  public void release(float lastX, float lastY) {
    
  }
  
  
  public AbstractTool getSelectedTool() {
    return toolbarModel.getSelectedTool();
  }
  
  
  public color switchLineColor() {
    return toolbarModel.switchLineColor();
  }
  
  
  public color switchCanvasColor() {
    return toolbarModel.switchCanvasColor();
  }
  
}
