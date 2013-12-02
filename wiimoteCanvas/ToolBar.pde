public class ToolBar extends AbstractToolbar {
  
  private int canvasH, canvasW;
  
  private float xOffset = 0.0;
  private float yOffset = 0.0;
  
//  private int selectedWeight, deselectedWeight;
  
//  private boolean isSelected;
//  private boolean isMoving;
  
  private ToolBarModel toolsModel;
  
  public ToolBar(int canvasWidth, int canvasHeight) {
    canvasW = canvasWidth;
    canvasH = canvasHeight;
    
    selectedWeight = 4;
    normalWeight = 2;
    
    isSelected = false;
//    isMoving = false;
    isShown = false;
    
    toolsModel = new ToolBarModel(canvasWidth, canvasHeight);
  }
  
  
  public void showToolbar() {
    toolsModel.showToolbar();
  }
  
  
  public void hideToolbar() {
    toolsModel.hideToolbar();
  }
  
  
  private void setSelected(boolean selected) {
    isSelected = selected;
  }
  
  
  public boolean selectedToolExists() {
    return toolsModel.selectedToolExists();
  }
  
  
  public AbstractTool getSelectedTool() {
    return toolsModel.getSelectedTool(); 
  }
  
  
  private void setMoving(boolean moving) {
//    isMoving = moving; 
  }
  
  
  public boolean iconsHit(float hitX, float hitY) {
    return toolsModel.iconsHit(hitX, hitY);
  }
  
  
  public boolean toolbarHit(float x, float y) {
    return toolsModel.toolbarHit(x, y);

  }
  
  
  public boolean toolbarBorderHit(float x, float y) {
    return toolsModel.toolbarBorderHit(x, y);
  }
  
  
  private void moveToolbar(float newX, float newY) {
    toolsModel.shiftCoords(newX, newY);
  }
  
  
  public void hoverCheck(float cursorX, float cursorY) {
    toolsModel.iconHoverCheck(cursorX, cursorY);
  }
  
  
  public void clickCheck(float clickX, float clickY) {
    toolsModel.clickCheck(clickX, clickY);
  }
  
  
  public void pressCheck(float pressX, float pressY) {
    toolsModel.pressCheck(pressX, pressY);
  }
  
  
  public void dragCheck(float dragX, float dragY) {
    toolsModel.dragCheck(dragX, dragY);
  }
  
  
  public void release(float lastX, float lastY) {
    toolsModel.release(lastX, lastY);
  }
  
  
  public AbstractShape createNewShape() {
    if (selectedToolExists()) {
      return getSelectedTool().createCanvasShape();
    }
    
    return null;
  }
  
  
  public color getCursorColor() {
    return toolsModel.getCursorColor(); 
  }
  
  
  public void drawToolbar() {
    
    if (toolsModel.toolbarShown()) {
      fill(toolsModel.getToolbarColor());
      stroke(255);
      strokeWeight(toolsModel.getToolbarWeight());
    
      rect(toolsModel.getToolbarX(), toolsModel.getToolbarY(), toolsModel.getToolbarW(), toolsModel.getToolbarH(), 7);
    
      // draw the tool icons in the toolbar.
      toolsModel.drawIcons();
    }
    
  }
  
}
  
  
