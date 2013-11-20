public class LineTool extends CanvasTool {
  
  int iconX, iconY;
  int lineWidth;
  
  public LineTool(int x, int y) {
    iconX = x;
    iconY = y;
    bgColor = color(0, 120, 180);
    lineWidth = 1;
  }
  
  public color getIconColor() {
    // if the tool is selected, the mouse/wiimote indicator color should match the tool color.
   return bgColor; 
  }
  
  public boolean wasClicked(int clickX, int clickY) {
    
    if ((clickX >= iconX) && (clickY >= iconY) && (clickX <= iconX + iconW) && (clickY <= iconY + iconH)) {
      return true;
    }
    
    return false;
  }
  
  public void drawIcon() {
    
    // if this tool is selected, make the icon outline thicker (and pulsing maybe?).
    if (isSelected) {
      strokeWeight(selectedWeight);
    } else {
      strokeWeight(normalWeight);
    }
    
    // draw the icon square.
    stroke(255);
    fill(bgColor); // set icon background color to blue.
    rect(iconX, iconY, iconW, iconH, iconCorner);
    
    // draw the line on top.
    strokeWeight(lineWidth);
//    stroke(colours[fillColour]); // commented out for simplicity right now, but should reflect the line color!
    stroke(0);
    line(iconX, iconY, iconX + iconW, iconX + iconH);
  }
  
}
