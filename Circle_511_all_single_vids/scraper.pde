void scrape(PImage pi) {
  // scrape for the strips
  loadPixels();

  if (observer.hasStrips) {
    registry.startPushing();
    registry.setAntiLog(true);
    registry.setLogging(true);
    registry.setOverallBrightnessScale(globalAlpha);
    List<Strip> strips = registry.getStrips();
    List<PixelPusher> pushers = registry.getPushers();
    //pushers.get(0).startRecording("cannedfile.dat");

    // our array is tall and narrow, so let's rotate this 90 degrees.
    // we can assume they're all the same length.

    // yscale = how many pixels of y == one led pixel.
    // xscale = how many pixels of x == one led strip.
    // int yscale = height / strips.get(0).getLength();
    // int xscale = width / strips.size();

    /*
     * PixelPusher has a method getControllerOrdinal()
     * returns the controller sorting number
     */
    int i = 0;
    for (Strip strip : strips) {      
      if(i%2 == 0) {
          circleScraper.scrapeStrip(strips.get(i), pi);
        try{
          circleScraper.scrapeStrip2(strips.get(i+1), pi);
        } finally {
        
        }
      }
      i++;
    }


  }
  updatePixels();
}

