class Button {
  
  color c;
  int x;
  int y;
  int w;
  int h;
  String s;
  
  
  Button(color c, int x, int y, int w, int h, String s) {
    this.c = c;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.s = s;
  }
  
  void draw() {
    fill(c);
    rect(x,y,w,h,20);
    fill(255);
    textSize(w);
    text(s,x+(w/2),y+(h/2));
  }
  
  boolean clicked(float clickX, float clickY) {
    return (clickX > x && clickX < x+w && clickY > y && clickY < y+h);
  }
  
  
}
