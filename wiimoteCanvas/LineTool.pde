public class LineTool extends AbstractTool {
  
  public LineTool() {
    iconColor = color(129, 98, 220);
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
  
  
  public LineShape createCanvasObject() {
      LineShape newLine = new LineShape();
      return newLine;
  }
  
}
