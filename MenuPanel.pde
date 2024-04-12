class MenuPanel {




  void draw(int i, String title) {
    fill(32, 32, 32);
    rectMode(CORNER);
    rect(0+(i*(width/3)), 0, width/3, height/3);
    text(title,10,10);
  }
}
