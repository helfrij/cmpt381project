public class ColorToolbar extends AbstractToolbar {
  
  private ColorToolbarModel toolbarModel;
  
  public ColorToolbar(int w, int h) {
    canvasWidth = w;
    canvasHeight = h;
    
    toolbarModel = new ColorToolbarModel(canvasWidth, canvasHeight);
  }
  
  
  public void drawToolbar() {
    
  }
  
  
  public void hideToolbar() {
    
  }
  
  
  public void showToolbar() {
    
  }
  
  
  public void pressCheck(float pressX, float pressY) {
    toolbarModel.pressCheck(pressX, pressY);
  }
  
  
  public void clickCheck(float clickX, float clickY) {
    toolbarModel.clickCheck(clickX, clickY);
  }
  
  
  public void hoverCheck(float hoverX, float hoverY) {
    toolbarModel.hoverCheck(hoverX, hoverY);
  }
  
  
  public AbstractTool getSelectedTool() {
    return toolbarModel.getSelectedTool();
  }
  
}
