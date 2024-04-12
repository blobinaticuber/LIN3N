class Button {
  
  color c;
  int x;
  int y;
  int w;
  int h;
  
  
  Button(color c, int x, int y, int w, int h) {
    this.c = c;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void draw() {
    fill(c);
    rectMode(CORNER);
    rect(x,y,w,h,20);
  }
  
  boolean clicked(float clickX, float clickY) {
    return (clickX > x && clickX < x+w && clickY > y && clickY < y+h);
  }
  
  
}
