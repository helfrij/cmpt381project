abstract class Shape {

  int x, y;
  int rotation;
  
  
  public abstract void drawShape();
  public abstract boolean checkHit(int x, int y);
  public abstract void setSelected();
  
}
