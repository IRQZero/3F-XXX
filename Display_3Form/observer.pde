class PusherObserver implements Observer {
  public boolean hasStrips = false;
  public boolean hasAllStrips = false;
  public void update(Observable registry, Object updatedDevice) {
    //println("Registry changed!");
    if (updatedDevice != null) {
      //println("Device change: " + updatedDevice);
    }
    this.hasStrips = true;
    if ( ((DeviceRegistry)registry).getPushers().size() >= 1) {
       this.hasAllStrips = true; 
    } else {
      this.hasAllStrips = false;
    }
  }
};

