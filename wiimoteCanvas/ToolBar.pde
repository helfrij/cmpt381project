public class ToolBar {
  int canvasH, canvasW;
  
  float xOffset = 0.0;
  float yOffset = 0.0;
  
  int selectedWeight, deselectedWeight;
  
  boolean isSelected;
  boolean isMoving;
  boolean isVertical;
  
  ToolBarModel toolsModel;
  
  public ToolBar(int canvasWidth, int canvasHeight) {
    canvasW = canvasWidth;
    canvasH = canvasHeight;
    
    selectedWeight = 4;
    deselectedWeight = 2;
    
    isSelected = false;
    isMoving = false;
    isVertical = true;
    
    toolsModel = new ToolBarModel(canvasWidth, canvasHeight);
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
  
  
  public boolean getDrawingState(float x, float y) {
    return toolsModel.getDrawingState(x, y);
  }
  
  
  private void setMoving(boolean moving) {
    isMoving = moving; 
  }
  
  
  private void setVertical() {
//    float oldW = toolsModel.getToolbarW();
//    float oldH = toolsModel.getToolbarH();
//    
//    // if the toolbar is already in the vertical orientation, make no changes.
//    if (isVertical == true || oldW <= oldH) {
//      return; 
//    }
//    
//    if (oldW > oldH) {
//      toolsModel.setVertical();
//      isVertical = true; 
//    }
  }
  
  
  private void setHorizontal() {
//    float oldW = toolsModel.getToolbarW();
//    float oldH = toolsModel.getToolbarH();
//    
//    // if the toolbar is already in the horizontal orientation, make no changes.
//    if (isVertical == false || oldH <= oldW) {
//      return; 
//    }
//    
//    if (oldH > oldW) {
//      toolsModel.setHorizontal();
//      isVertical = false;
//    }
  }
  
  
  private boolean wasClicked(int x, int y) {
    return toolsModel.toolbarHit(x, y);
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
  
  
  public void released(float lastX, float lastY) {
    toolsModel.release(lastX, lastY);
  }
  
  
  public color getCursorColor() {
    return toolsModel.getCursorColor(); 
  }
  
  
  public void drawToolBar() {
    fill(toolsModel.getToolbarColor());
    stroke(255);
    strokeWeight(toolsModel.getToolbarWeight());
    
    rect(toolsModel.getToolbarX(), toolsModel.getToolbarY(), toolsModel.getToolbarW(), toolsModel.getToolbarH(), 7);
    
    // draw the tool icons in the toolbar.
    toolsModel.drawIcons();
  }
  
}
  
  
