import g4p_controls.*;

import javax.swing.*; 
import processing.video.*;
import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.*;
import java.util.*;
import processing.core.*;

int globalStretch = 333;
Movie myMovie;
String vidvid;
boolean fileChosen = false;
DeviceRegistry registry;
PusherObserver observer;
CircleScraper circleScraper;
int testPixel = 0;

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

float yPos;
float xPos;
float size;
int upPressed;
int downPressed;
float globalAlpha = 0.9;
int cnt = 0;

void setup() {
  size(870, 870, P3D);
  yPos = 0;
  xPos = 0;
  //xPos2 = width / 2;
  //size = height * width / 1000.0;
  registry = new DeviceRegistry();
  registry.setAntiLog(true);
  observer = new PusherObserver();
  registry.addObserver(observer);
  circleScraper = new CircleScraper(xPos, yPos, 1.0, 1.0);
  
  try { 
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
  } 
  catch (Exception e) {
    e.printStackTrace();
  }

  selectInput("Select a video:", "fileSelected");
}

void draw() {
  
  if (fileChosen) {
    //image(myMovie, -globalStretch, 0, width, height);
    image(myMovie, 0, 0, width, height);
    scrape(this.g);
  }
}

void keyPressed() 
{
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      //myMovie.pause();
      if (globalAlpha < 1.0) 
      {
        globalAlpha += 0.1;
        println(globalAlpha);
      }
    } else if (keyCode == DOWN) 
    {
      globalAlpha -= 0.1;
      println(globalAlpha);
    } else if (keyCode == LEFT) 
    {

      //globalStretch -= 1;
      //println(globalStretch);
    } else if (keyCode == RIGHT) 
    {
      //globalStretch += 1;
      //println(globalStretch);
    } else if (key == 'p') 
    {

    }
  } else {
    // nothing
  }
}

void movieEvent(Movie m) {
  m.read();
}

