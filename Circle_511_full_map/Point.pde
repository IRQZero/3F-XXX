/*
This software copyright Digital Ambience, 2014.
This software may not be used for any commercial purpose. 
The only rights granted are for demonstration of capabilities of the software of Digital Ambience.
Any use outside of the expressed and written agreements between Digital Ambience and its business associates is a violation of this copyright and good faith between parties. 
Author: M. Howell (matthewdhowell@gmail.com)
*/

class Point {
  float x;
  float y; 

  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }

  Point add(Point b) {
    return new Point(this.x + b.x, this.y+b.y);
  }
  
  Point scale(float sX, float sY) {
    return new Point(this.x * sX, this.y * sY);
  }
  
  void rotate90() {
    float t = x;
    x=y;
    y=t; 
  }
  
  Point invertX() {
   return new Point(-(x), y); 
  }
  Point invertY() {
   return new Point(x, -(y)); 
  }

  @Override public String toString() {
    return new String(" "+x+","+y);
  }
}

