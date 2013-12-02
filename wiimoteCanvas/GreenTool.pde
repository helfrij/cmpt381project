public class GreenTool extends AbstractTool {
  
  int colorValue = 255;
  
  public GreenTool() {
    iconColor = color(0, colorValue, 0);
  }
  
  
  public void drawIcon(float xPos, float yPos, float size) {
    iconX = xPos;
    iconY = yPos;
    iconSize = size;
    
    fill(iconColor, opacity);
    stroke(255);
    strokeWeight(weight);
    rect(iconX, iconY, iconSize, iconSize, 7);
  }
  
  
  public AbstractShape createCanvasShape() {
    return null;
  }
  
  
  public int getValue() {
    return colorValue;
  }


  public void increaseValue() {
    colorValue++;
    
    if (colorValue > 255) {
      colorValue = 255;
    }
  }  
  
  
  public void decreaseValue() {
    colorValue--;
    
    if (colorValue < 0) {
      colorValue = 0;
    }
  }  
  
}
