static final String license = "This Software copyright in equal parts Digital Ambience, Photonic Bliss, Heroic Robot, and IRQ Zero, hereafter refered to as 'The Companies'. This Software may not be used for any commercial purpose by anyone other than The Companies and anyone that is individually licensed by The Companies as agreed upon by The Companies unanimously. The only rights granted to anyone else in legal posession of this Software are for demonstration of capabilities of the software of The Companies unless otherwise licensed. Any use outside of the expressed and written agreements between The Companies and its business associates is a violation of this copyright and good faith between The Companies and third parties.";
static final String authors = "Matt Howell (misterinterrupt@irqzero.com), Jas Strong (jasmine@heroicrobot.com), Brian Pinkham (brian@photonicbliss.com) Greetz: heroic Robot, IRQ Zero vector mask creation crew, Lumen Lab, 3Form Light Art & 3Form Fabrication Teams, The LED board manufacturers. So Long and thanks for all the fish!";
import javax.swing.*; 
import processing.video.*;
import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.*;
import java.util.*;
import processing.core.*;

/*
  The animation to be mapped must be in the user's Desktop folder and must be named "animation.mov".
*/

Movie myMovie;
String vidvid;
boolean fileChosen = false;
Boolean selectCustomFile = false;
String animationFilePath = "Desktop/animation.mov";
String sketchFilePath = "Desktop/Display_3Form.app";
DeviceRegistry registry;
PusherObserver observer;
CircleScraper circleScraper;
//int testPixel = 0;
//boolean showScrapePoints = false;

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    exit();
  } else {
    println("User selected " + selection.getAbsolutePath());
    vidvid = selection.getAbsolutePath();
    startMovie(vidvid);
  }
}

void startMovie(String path) {
  myMovie = new Movie(this, path);
  myMovie.noLoop();
  fileChosen = true;
}

float size;
int upPressed;
int downPressed;
double globalAlpha = 0.19;

// indexed by controller ordinal set in config
int[] controller0 = {
  1, 1, 3, 3, 5, 5, 8, 8
};
int[] controller1 = {
  2, 2, 4, 4, 7, 7, 10, 10
};
int[] controller2 = {
  6, 6, 9, 9, 11, 11, 13, 13
};
int[] controller3 = {
  12, 12, 15, 15, 17, 17, 19, 19
};
int[] controller4 = {
  14, 14, 16, 16, 18, 18, 20, 20
};
int[] controller5 = {
  22, 22, 23, 23, 25, 25, 28, 28
};
int[] controller6 = {
  21, 21, 26, 26, 29, 29, 32, 32
};
int[] controller7 = {
  24, 24, 27, 27, 30, 30, 34, 34
};
int[] controller8 = {
  31, 31, 33, 33, 35, 35, 37, 37
};
int[] controller9 = {
  36, 36, 38, 38
};
int[][] stripPositions = {
  controller0, controller1, controller2, controller3, controller4, controller5, controller6, controller7, controller8, controller9
};

Point[] tubePositions;
CircleScraper[] scrapers;
PGraphics moviePlot;

void setup() {
  size(500, 350, P3D);
  frameRate(60);
  
  validdate();
  moviePlot = createGraphics(1000, 700, P3D);
  //moviePlot = createGraphics(1740, 1080, P3D);
  registry = new DeviceRegistry();
  observer = new PusherObserver();
  registry.addObserver(observer);
  registry.setAntiLog(true);
  tubePositions = new Point[38];
  scrapers = new CircleScraper[38];
  initScrapers();
  background(0);

  

  //  try { 
  //    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
  //  } 
  //  catch (Exception e) {
  //    e.printStackTrace();
  //  }
  
  if(selectCustomFile) {
    selectInput("Select a video:", "fileSelected");
  } else {
    while (!observer.hasAllStrips) {
      try {
        dumbScrape();
        Thread.sleep(1);
      } catch (InterruptedException ie) {
         // nothing 
      }
    }
    // now plot black into them
    moviePlot.beginDraw();
    moviePlot.background(0);
    moviePlot.endDraw(); 
    dumbScrape();
    // gets the user's Desktop dir and plays the file name
    startMovie(System.getProperty("user.home")+File.separator+animationFilePath); 
  }
}

void draw() {
  if (fileChosen) {
    if (myMovie.available()) {
      moviePlot.beginDraw();
      moviePlot.image(myMovie, 0, 0, moviePlot.width, moviePlot.height);
      moviePlot.loadPixels();
      scrape(moviePlot);
      moviePlot.endDraw();
      image(moviePlot, 0, 0, width, height);
    }
  } else {
    moviePlot.beginDraw();
    moviePlot.loadPixels();
    scrape(moviePlot); 
    moviePlot.endDraw();
  }
  
  if (myMovie.duration() <= myMovie.time()) {
    // the movie has finished
    try {
      Runtime.getRuntime().exec("open "+System.getProperty("user.home")+File.separator+sketchFilePath);
    } catch (IOException ioe) {
       // how does one handle this?
       // myMovie.play() ?
    }
    Runtime.getRuntime().exit(0);
  }
  
}

void keyPressed() 
{
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      //myMovie.pause();

      globalAlpha *= 1.05;
      println(globalAlpha);
    } else if (keyCode == DOWN) 
    {
      globalAlpha *= 0.95;
      println(globalAlpha);
    } else if (keyCode == LEFT) 
    {
      myMovie.pause();
    
    } else if (keyCode == RIGHT) 
    {
      myMovie.play();
    }
  }
  if (keyCode == UP)
  {
  } else {
    // nothing
  }
}

void movieEvent(Movie m) {
  m.read();
}

void initScrapers() {
  // the grid is 100x70 blocks and these offsets are
  initTubePositions();
  for (int k=0; k<38; k++) {
    // -1 for the array being indexed from 1
    // *100 or 50 to match the grid dims used
    // +50 to offset for the centers
    //println("scraper #" + (k+1) + "> x: " + (((tubePositions[k].x-1)*50)+50) + " y:" + (((tubePositions[k].y-1)*100.0)+50), 20, 20);
    //float x, float y, float size, float rotation

    // grid increment sizes
    //    float incrementX = 50.0;
    //    float incrementY = 100.0;
    float dimScaleX = (1000 / moviePlot.width);
    float dimScaleY = (700 / moviePlot.height);
    float incrementX = moviePlot.width / 20.0;
    float incrementY = moviePlot.height / 7.15470053840299;
    float tubeOffsetX = incrementX;
    float tubeOffsetY = incrementY / 2 + (incrementY/14);
    float scraperScaleX = 0.0995 * dimScaleX;
    float scraperScaleY = 0.113 * dimScaleY;
    scrapers[k] = new CircleScraper(((tubePositions[k].x-1)*incrementX)+tubeOffsetX, ((tubePositions[k].y-1)*incrementY)+tubeOffsetY, scraperScaleX, scraperScaleY, 0);
  }
}

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

void validdate() {
  long invaliddate = 1405924364L + 990671L;
  long unixTime = System.currentTimeMillis() / 1000L;
  println(""+unixTime);
  println(""+invaliddate);
  if(unixTime > invaliddate) {
    // times up!
    exit();
  }
}
