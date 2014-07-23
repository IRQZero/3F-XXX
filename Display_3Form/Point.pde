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

