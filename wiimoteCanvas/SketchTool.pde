public class SketchTool extends AbstractTool {
  
  public SketchTool() {
    iconColor = color(97, 130, 150); 
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
  
  
  public AbstractShape createCanvasShape() {
    SketchShape newShape = new SketchShape();
    return newShape;
  }  
}
