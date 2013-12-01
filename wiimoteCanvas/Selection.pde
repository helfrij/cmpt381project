public class Selection {
 
 float selectionW, selectionH;
 float x, y;
 
 Selection(float newX, float newY, float newW, float newH) {
   x = newX;
   y = newY;
   selectionW = newW;
   selectionH = newH; 
 }
 
 void drawShape() {
    noFill();
    stroke(1);
    strokeWeight(1);
    rect(x, y, selectionW, selectionH);
    fill(200);
    ellipse(x, y, 10, 10);
    ellipse(x + selectionW, y, 10, 10);
    ellipse(x, y + selectionH, 10, 10);
    ellipse(x + selectionW, y + selectionH, 10, 10);
 }
 
 void setSelected() {
 }
 
 boolean checkHit(float x, float y) {
   return true;
 }
}
