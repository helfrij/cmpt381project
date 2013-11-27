public class NoTool extends AbstractTool {
  
  public NoTool() {
    iconColor = color(0, 0, 0);
  } 
  
  
  public void drawIcon(float x, float y, float size) {
    iconX = x;
    iconY = y;
    iconSize = size;
    
    fill(iconColor, opacity);
    stroke(255);
    strokeWeight(weight);
    rect(iconX, iconY, iconSize, iconSize, 7);
  }
  
  
  public void setFirstPoint(float x, float y) {
    
  }
  
  
  public void addPoint(float x, float y) {
    
  }
  
  
  public void setLastPoint(float x, float y) {
    
  }
  
  
  public AbstractShape createCanvasObject() {
    // no tool means no drawings!
    return null;
  }
  
}
