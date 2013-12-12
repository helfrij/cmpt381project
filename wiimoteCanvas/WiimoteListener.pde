public class WiimoteListener implements WiiRemoteListener {
 
 public WiimoteListener() {
 } 
  
  boolean accel;
  
  void WiimoteListener() {
    accel = true;
  }
   
  
 public void accelerationInputReceived(WRAccelerationEvent e) {
   float x = (float) e.getXAcceleration();
   float y = (float) e.getYAcceleration();
   float z = (float) e.getZAcceleration();
      
    println("X: " + x);
    println("Y: " + y);
    println("Z: " + z);
   
   //Shake gesture : Crazy
   
   
   //Rotate
     //println(e.getRoll());
     double rotation = e.getRoll();
     if(Double.isNaN(rotation)) {
       if(abs(x-.5)>abs(y+1.1) && abs(x-.5)>abs(z)) {
         //X Gesture : change Line colour
         model.switchLineColor();
       }
       else if(abs(y+1.1-.5)>abs(x) && abs(y+1.1-.5)>abs(z)) {
         //Y Gesture : change line width
         model.switchLineWidth();
       }
     }
     else {
       if(!accel) {
         model.rotateSelection((float) rotation/20);
       }
     }
}
 
 public void buttonInputReceived(WRButtonEvent e) {
   
   if (e.wasReleased(WRButtonEvent.B)) {
     accel = !accel;
     try {
      remote.setAccelerometerEnabled(accel);
      remote.setIRSensorEnabled(accel, WRIREvent.BASIC);
      } catch(IOException ioe) {
        println("IOException caught");
      } catch(IllegalStateException ise) {
        println("IllegalStateException caught");
      } catch(IllegalArgumentException iae) {
        println("IllegalArgumentException caught");
      }
   }
   if (e.wasReleased(WRButtonEvent.PLUS)) {
     model.clearCanvas();
   }
   if (e.wasReleased(WRButtonEvent.MINUS)) {
     remote.disconnect();
   }
   if(e.wasReleased(WRButtonEvent.ONE)) {
     model.switchToolbar();
   }
   if (e.wasReleased(WRButtonEvent.TWO)) {
     canvasColor = model.switchCanvasColor();
   }
   
   //A button
   if (e.isPressed(WRButtonEvent.A)) {
     model.clickCheck(cursorX, cursorY);
   }
   if (e.wasReleased(WRButtonEvent.A)) {
     model.release(cursorX, cursorY);
   }
 }
 
 public void extensionInputReceived(WRExtensionEvent e) { 
 }
 
 public void statusReported(WRStatusEvent e) {
 }
 
 public void IRInputReceived(WRIREvent e) {
   
   println("Getting IR input...");
   
   for(IRLight light : e.getIRLights()) {
     if(null != light) {
       cursorX = (int) light.getX() * canvasH;
       cursorY = (int) light.getY() * canvasW;
     }
   }

   println(cursorX + " " + cursorY); 
 }
 
 public void extensionConnected(WiiRemoteExtension e) {
 }
 
 public void disconnected() {
 }
 
 public void extensionDiconnected(WiiRemoteExtension e) {
 }
 
 public void extensionDisconnected(WiiRemoteExtension e) {
 }
 
 public void extensionUnknown() {
 }
 
 public void combinedInputReceived(WRCombinedEvent e) {
   
 }
 
 public void extensionPartiallyInserted() {
 }
 
 
}
