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
  
  Point scale(float s) {
    return new Point(this.x * s, this.y * s);
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
};
