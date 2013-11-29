//public class AbstractShape extends Shape {
// 
//  ArrayList<Circle> points;
//  int width;
//  color abstractColour;
//  
//  boolean isSelected;
//  
//  int maxX, maxY, minX, minY, avgX, avgY;
//  
//  
// public AbstractShape(ArrayList<Circle> newPoints, int newWidth, color newColour) {
//   points = newPoints;
//   width = newWidth;
//   abstractColour = newColour;
//   isSelected = false;
//   rotation = (int) PI/2;
//   
//   maxX = points.get(0).getX();
//   maxY = points.get(0).getY();
//   minX = points.get(0).getX();
//   minY = points.get(0).getY();  
//        
//   for(Circle c : points) {
//     maxX = max(maxX, c.getX());
//     minX = min(minX, c.getX());
//     maxY = max(maxY, c.getY());
//     minY = min(minY, c.getY());  
//     
//     c.setX(c.getX() - avgX);
//     c.setY(c.getY() - avgY);   
//   }
//   
//   avgX = (maxX+minX)/2;
//   avgY = (maxY+minY)/2; 
// }
// 
// public void setSelected() {
//   isSelected = !isSelected;
// }
//
// public boolean checkHit(int x, int y) {
//   for(Circle c : points) {
//    if((x<(c.getX()+15) && (x>c.getX()-15)) && ((y<(c.getY()+15)) && (y>c.getY()-15))) {
//      return true;
//    }
//   }
//   return false;
// }
//
//
// public void drawShape() {
//   stroke(abstractColour);
//   strokeWeight(width);
//   if(points.isEmpty())
//     return;   
//  
//   /*for(Circle c : points) {
//     c.setX(c.getX() - avgX);
//     c.setY(c.getY() - avgY);
//   }*/
//   
//   Circle prev;
//     
//   pushMatrix();
//
//   //translate(avgX, avgY);
//   //rotate(rotation);
//      
//   prev = points.get(0);
//   for(Circle c : points) {
//     line(c.getX(), c.getY(), prev.getX(), prev.getY());
//     prev = c;
//   }
//   popMatrix();
//   
//   if(isSelected) {
//     Selection select = new Selection(minX, minY, maxX-minX, maxY-minY);
//     select.drawShape();
//   }
//  }
//  
//}

