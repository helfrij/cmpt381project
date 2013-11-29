public class WiimoteListener implements WiiRemoteListener {
 
 public WiimoteListener() {
 } 
  
 public void accelerationInputReceived(WRAccelerationEvent e) {
   println(e.getXAcceleration() + " " + e.getYAcceleration() + " " + e.getZAcceleration());
 }
 
 public void buttonInputReceived(WRButtonEvent e) {
//   if (e.isPressed(WRButtonEvent.B)) {
////     remote.disconnect();
//   }
//   if (e.wasReleased(WRButtonEvent.PLUS)) {
//     if(lineWidth <= 20)
//       lineWidth++;
//   }
//   if (e.wasReleased(WRButtonEvent.MINUS)) {
//     if(lineWidth>0)
//       lineWidth--;
//   }
//   if(e.wasReleased(WRButtonEvent.LEFT)) {
//     if(fillColour>0)
//       fillColour--;
//     else if (0 == fillColour)
//       fillColour = 5;
//   }
//   if (e.wasReleased(WRButtonEvent.RIGHT)) {
//     if(fillColour<5)
//       fillColour++;
//     else if(5 == fillColour)
//       fillColour = 0;
//   }
 }
 
 public void extensionInputReceived(WRExtensionEvent e) { 
 }
 
 public void statusReported(WRStatusEvent e) {
 }
 
 public void IRInputReceived(WRIREvent e) {
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
