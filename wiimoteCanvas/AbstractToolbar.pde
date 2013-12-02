public abstract class AbstractToolbar {
  
  public boolean isShown;
  public boolean isSelected;
  
  public int selectedWeight = 4;
  public int hoverWeight = 4;
  public int normalWeight = 2;
  public int weight = normalWeight;
  
  public int canvasWidth, canvasHeight;
  
  public abstract void drawToolbar();

  public abstract boolean toolbarHit(float hitX, float hitY);
  public abstract boolean iconsHit(float hitX, float hitY);
  public abstract boolean toolbarBorderHit(float hitX, float hitY);
  
  public abstract void clickCheck(float clickX, float clickY);
  public abstract void pressCheck(float pressX, float pressY);
  public abstract void hoverCheck(float hoverX, float hoverY);
  public abstract void dragCheck(float dragX, float dragY);
  public abstract void release(float lastX, float lastY);
  
  public abstract AbstractTool getSelectedTool();
  
  public void showToolbar() {
    isShown = true;
  }
  
  
  public void hideToolbar() {
    isShown = false;
  }
  
}
