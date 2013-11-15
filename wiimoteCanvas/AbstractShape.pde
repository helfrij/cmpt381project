public class AbstractShape extends Shape {
 
  ArrayList<Circle> points;
  int width;
  color abstractColour;
  
  boolean isSelected;
  
  int maxX, maxY, minX, minY;
  
 public AbstractShape(ArrayList<Circle> newPoints, int newWidth, color newColour) {
   points = newPoints;
   width = newWidth;
   abstractColour = newColour;
   isSelected = false;
 }
 
 public void setSelected() {
   isSelected = !isSelected;
 }

 public boolean checkHit(int x, int y) {
   for(Circle c : points) {
    if((x<(c.getX()+15) && (x>c.getX()-15)) && ((y<(c.getY()+15)) && (y>c.getY()-15))) {
      return true;
    }
   }
   return false;
 }

 public void drawShape() {
   stroke(abstractColour);
   strokeWeight(width);
   if(points.isEmpty())
     return;
     
   maxX = points.get(0).getX();
   maxY = points.get(0).getY();
   minX = points.get(0).getX();
   minY = points.get(0).getY();  
     
   Circle prev = points.get(0);
   
   for(Circle c : points) {
     maxX = max(maxX, c.getX());
     minX = min(minX, c.getX());
     maxY = max(maxY, c.getY());
     minY = min(minY, c.getY());
     
     line(c.getX(), c.getY(), prev.getX(), prev.getY());
     prev = c;
   }
   
   if(isSelected) {
     Selection select = new Selection(minX, minY, maxX-minX, maxY-minY);
     select.drawShape();
   }
  }
  
}

