void scrape(PImage pi) {
  // scrape for the strips
  loadPixels();

  if (observer.hasAllStrips) {
    registry.startPushing();
    registry.setLogging(false);
    registry.setOverallBrightnessScale(globalAlpha);
    List<Strip> strips = registry.getStrips();
   // List<PixelPusher> pushers = registry.getPushers();

    // yscale = how many pixels of y == one led pixel.
    // xscale = how many pixels of x == one led strip.
    // int yscale = height / strips.get(0).getLength();
    // int xscale = width / strips.size();

    /*
     * PixelPusher has a method getControllerOrdinal()
     * returns the controller sorting number
     */
    for(Iterator<Strip> it=strips.iterator(); it.hasNext();) {
         Strip strip = it.next();
         int stripLength = strip.getLength();
         int currentStripNumber = strip.getStripNumber();
         int currentControllerID = strip.getPusher().getControllerOrdinal();      
         int pos = stripPositions[currentControllerID-1][currentStripNumber];
         int boardOffset = currentStripNumber % 2;
         scrapers[pos-1].scrapeStrip(boardOffset, strip, pi);
    }


  }
  updatePixels();
}

void dumbScrape() {
  List<Strip> strips = registry.getStrips();
  for(Iterator<Strip> it=strips.iterator(); it.hasNext();) {
         Strip strip = it.next();
         int stripLength = strip.getLength();
         for (int i=0; i<stripLength; i++)
           strip.setPixel(#000000, i);
         
  }
}
