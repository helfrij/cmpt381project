public class Selection extends Shape {
 
 int width, height;
 
 Selection(int newX, int newY, int newW, int newH) {
   x = newX;
   y = newY;
   width = newW;
   height = newH; 
 }
 
 void drawShape() {
    noFill();
    stroke(1);
    strokeWeight(1);
    rect(x, y, width, height);
    fill(200);
    ellipse(x, y, 10, 10);
    ellipse(x+width, y, 10, 10);
    ellipse(x, y+height, 10, 10);
    ellipse(x+width, y+height, 10, 10);
 }
 
 void setSelected() {
 }
 
 boolean checkHit(int x, int y) {
   return true;
 }
}
