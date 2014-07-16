/*
This software copyright Digital Ambience, 2014.
This software may not be used for any commercial purpose. 
The only rights granted are for demonstration of capabilities of the software of Digital Ambience.
Any use outside of the expressed and written agreements between Digital Ambience and its business associates is a violation of this copyright and good faith between parties. 
Author: M. Howell (matthewdhowell@gmail.com)
*/

class PusherObserver implements Observer {
  public boolean hasStrips = false;
  public void update(Observable registry, Object updatedDevice) {
    //println("Registry changed!");
    if (updatedDevice != null) {
      //println("Device change: " + updatedDevice);
    }
    this.hasStrips = true;
  }
};

