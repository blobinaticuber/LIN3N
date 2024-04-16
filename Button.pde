class Button {
  
  color c;
  int x;
  int y;
  int w;
  int h;
  int r;
  
  
  Button(color c, int x, int y, int w, int h, int r) {
    this.c = c;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = r;
  }
  
  void draw() {
    fill(c);
    rectMode(CORNER);
    rect(x,y,w,h,r);
  }
  
  boolean clicked(float clickX, float clickY) {
    return (clickX > x && clickX < x+w && clickY > y && clickY < y+h);
  }
  
  
}
