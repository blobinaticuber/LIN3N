// LIN3N is an N-dimensional 3-layered Rubik's Cube simulator
// By le epic Rowan Fortier (tm)
// Copyright 2024 Hypercubers (tm?)

int viewOffset = 0;
float zoomwee = 1.0;
float clickX;
float clickY;
color bg = color(64);
Menu menu = new Menu();
Puzzle puzzle = new Puzzle(menu.puzzleSize);
// default puzzle is 3^2

void setup() {
  size(800, 800, P3D);
  surface.setLocation(100, 100);
}


void draw() {
  background(bg);
  pushMatrix();
  // translate the puzzle to the center of the screen, plus the offset
  translate(width/2+viewOffset, height/2);
  // translate to where the mouse is, zoom in centered on that
  //translate(mouseX,0);
  scale(abs(zoomwee));
  //translate(-1*mouseX,0);
  // undo the mouse translation
  puzzle.draw();
  popMatrix();
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

  // piece clicking stuff
  clickX = ((mouseX-width/2)/zoomwee)-(viewOffset/zoomwee);
  clickY = ((mouseY-height/2)/zoomwee);
  for (Piece p : puzzle.pieces) {
    if (p.clickCheck(clickX, clickY)) println("clicked on piece " + p.idx + ", which is a " + p.getC() + "c");
  }
}
