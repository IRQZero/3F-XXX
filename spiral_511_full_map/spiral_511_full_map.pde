import g4p_controls.*;

import javax.swing.*; 
import processing.video.*;
import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.*;
import java.util.*;
import processing.core.*;


Movie myMovie;
PImage mask;
String vidvid;
boolean fileChosen = false;
DeviceRegistry registry;
PusherObserver observer;
//SpiralScraper spiralScraper;
//int testPixel = 0;


int yPos;
int xPos;
float size;
int upPressed;
int downPressed;
float globalAlpha = 1;
int tubeoffsetX = 100;

// indexed by controller ordinal set in config
int[] controller0 = {4, 10, 2, 7};
int[] controller1 = {5, 3, 1, 8};
int[] controller2 = {6, 9, 13};
int[] controller3 = {18, 14, 16, 11};
int[] controller4 = {15, 19, 12, 17};
int[] controller5 = {25, 20, 22, 28};
int[] controller6 = {23, 26, 21, 27, 24};
int[] controller7 = {29, 37, 35, 31, 33};
int[] controller8 = {32, 36, 38, 34, 30};
int[][] stripPositions = {controller0,controller1,controller2,controller3,controller4,controller5,controller6,controller7,controller8};

// inited via function below
Point[] tubePositions;
SpiralScraper[] scrapers;

void setup() {
  size(1000, 700, P3D);
  yPos = height / 2;
  xPos = width / 2;
  size = height * width / 70;
  registry = new DeviceRegistry();
  observer = new PusherObserver();
  registry.addObserver(observer);
  registry.setAntiLog(true);
  tubePositions = new Point[38];
  initTubePositions();
  
  // set system look and feel
  try { 
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); 
  } catch (Exception e) {
    e.printStackTrace();
  }

  selectInput("Select a video:", "fileSelected");
}

void draw() {
  if(fileChosen) {
      //println(":: draw frame ::");
      scrapers = new SpiralScraper[38];
      initScrapers();
      image(myMovie, 0, 0, width, height);
      scrape(this.g);
  }
}

boolean allIdentified() {
    return true;
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    exit();  
  } else {
    println("User selected " + selection.getAbsolutePath());
    vidvid = selection.getAbsolutePath();
    myMovie = new Movie(this, vidvid);
    myMovie.loop();
    fileChosen = true;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if(globalAlpha >= 0.0) {
        globalAlpha += 0.1;
      }
    } else if (keyCode == DOWN) {
      if(globalAlpha > 0.0) {
        globalAlpha -= 0.1;
      }
    } else if (keyCode == LEFT) {
      if(tubeoffsetX >= 0) {
        tubeoffsetX += 10;
      }
    } else if (keyCode == DOWN) {
      if(tubeoffsetX > 0) {
        tubeoffsetX -= 10;
      }
    } 
  } else {
    // nothing
  }
}

void scrape(PImage pi) {
  if (observer.hasStrips) {
    registry.startPushing();
    registry.setAntiLog(true);
    registry.setLogging(false);
    List<Strip> strips = registry.getStrips();
    
    //List<PixelPusher> pushers = registry.getPushers();
    //int stripIndex = 0;
    colorMode(HSB, 255);
    //Strip strip = strips.get(0);
    for(Strip strip: strips) {
      int stripLength = strip.getLength();
      int currentStripNumber = strip.getStripNumber();
      int currentControllerID = strip.getPusher().getControllerOrdinal();
      int pos = stripPositions[currentControllerID-1][currentStripNumber];
      scrapers[pos-1].scrapeStrip(strip, pi, globalAlpha);
    }
  }
}

void movieEvent(Movie m) {
  m.read();
}

void initScrapers() {
  // the grid is 100x70 blocks and these offsets are
  for(int k=0; k<38; k++) {
    // -1 to fix my counting mistake
    // *100 or 50 to match the grid dims used
    // +50 to offset for the centers
    //println("scraper #" + (k+1) + "> x: " + (((tubePositions[k].x-1)*50)+50) + " y:" + (((tubePositions[k].y-1)*100.0)+50), 20, 20);
    scrapers[k] = new SpiralScraper(k, ((tubePositions[k].x-1)*50)+50, ((tubePositions[k].y-1)*100.0)+50, 0.07, 0.0);
  }
}
// 10,000 needs to be scaled to what in order to be 70,000
// 1000 scaled to 100/70

// positions of tube centers
void initTubePositions() {
  tubePositions[0] = new Point(1.0, 5.0);
  tubePositions[1] = new Point(3.0, 3.0);
  tubePositions[2] = new Point(3.0, 5.0);
  tubePositions[3] = new Point(4.0, 4.0);
  tubePositions[4] = new Point(4.0, 6.0);
  tubePositions[5] = new Point(5.0, 1.0);
  tubePositions[6] = new Point(5.0, 3.0);
  tubePositions[7] = new Point(5.0, 5.0);
  tubePositions[8] = new Point(6.0, 2.0);
  tubePositions[9] = new Point(6.0, 4.0);
  tubePositions[10] = new Point(7.0, 3.0);
  tubePositions[11] = new Point(7.0, 5.0);
  tubePositions[12] = new Point(8.0, 2.0);
  tubePositions[13] = new Point(8.0, 4.0);
  tubePositions[14] = new Point(8.0, 6.0);
  tubePositions[15] = new Point(9.0, 3.0);
  tubePositions[16] = new Point(9.0, 5.0);
  tubePositions[17] = new Point(10.0, 4.0);
  tubePositions[18] = new Point(10.0, 6.0);
  tubePositions[19] = new Point(11.0, 3.0);
  tubePositions[20] = new Point(11.0, 5.0);
  tubePositions[21] = new Point(12.0, 2.0);
  tubePositions[22] = new Point(12.0, 4.0);
  tubePositions[23] = new Point(12.0, 6.0);
  tubePositions[24] = new Point(13.0, 3.0);
  tubePositions[25] = new Point(13.0, 5.0);
  tubePositions[26] = new Point(13.0, 7.0);
  tubePositions[27] = new Point(14.0, 2.0);
  tubePositions[28] = new Point(14.0, 4.0);
  tubePositions[29] = new Point(14.0, 6.0);
  tubePositions[30] = new Point(15.0, 3.0);
  tubePositions[31] = new Point(15.0, 5.0);
  tubePositions[32] = new Point(16.0, 4.0);
  tubePositions[33] = new Point(16.0, 6.0);
  tubePositions[34] = new Point(17.0, 3.0);
  tubePositions[35] = new Point(17.0, 5.0);
  tubePositions[36] = new Point(18.0, 2.0);
  tubePositions[37] = new Point(19.0, 5.0);
}
