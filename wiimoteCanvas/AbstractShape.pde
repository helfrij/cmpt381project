public class AbstractShape extends Shape {
 
  ArrayList<Circle> points;
  int width;
  color abstractColour;
  
 public AbstractShape(ArrayList<Circle> newPoints, int newWidth, color newColour) {
   points = newPoints;
   width = newWidth;
   abstractColour = newColour;
 }

 public void drawShape() {
   stroke(abstractColour);
   strokeWeight(width);
   Circle prev = points.get(0);
   
   for(Circle c : points) {
     line(c.getX(), c.getY(), prev.getX(), prev.getY());
     prev = c;
   }
 } 
}
