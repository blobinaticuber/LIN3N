// LIN3N is an N-dimensional 3-layered Rubik's Cube simulator
// By le epic Rowan Fortier (tm)
// Copyright 2024 Hypercubers (tm?)

int viewOffset = 0;
float zoomwee = 1.0;
Menu menu;

void setup() {
  size(800, 800, P3D);
  surface.setLocation(100, 100);
  menu = new Menu();
}


void draw() {
  background(menu.bgColour);
  menu.draw();
}

void keyPressed() {
  // keybinds eventually?
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoomwee += e/10.0;
  zoomwee = abs(zoomwee);
}

void mouseDragged() {
  // if the mouseY is not over the menu, do dragging
  if (mouseY < 2*height/3 && mouseY > height/3) {
    viewOffset -= ((pmouseX-mouseX));
  }
}

void mousePressed() {
  // Menu stuff
  menu.handleClicks(mouseX, mouseY);
}
