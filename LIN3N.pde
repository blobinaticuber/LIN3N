// LIN3N is an N-dimensional 3-layered Rubik's Cube simulator
// By le epic Rowan Fortier (tm)
// Copyright 2024 Hypercubers (tm?)

int viewOffset = 0;
float zoomwee = 1.0;
float mouseDragXStart = 0.0;
float mouseDragYStart = 0.0;
float clickX;
float clickY;
color bg = color(64);

void setup() {
  size(800, 800, P3D);
  surface.setLocation(100, 100);
}

Menu menu = new Menu();
Puzzle puzzle = new Puzzle(menu.puzzleSize);





void draw() {
  background(bg);
  menu.draw();

  pushMatrix();
  translate(width/2+viewOffset, height/2);
  scale(abs(zoomwee));
  puzzle.draw();
  popMatrix();
}

void drawDebugText() {
  fill(255, 255, 255);
  textSize(24);
  text("Puzzle: 3^" + puzzle.dim, 10, 24);
  text("Mouse click X: " + clickX, 10, 48);
  text("Mouse click Y: " + clickY, 10, 72);
  //text("Number of pieces: " + (int)pow(3, puzzle.dim), 10, 48);
  //text("For each piece i want to draw " + (1+(2*(puzzle.dim-1))) + " stickers", 10, 72);
}

void keyPressed() {
  // keybinds eventually?
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoomwee += e/10.0;
}

void mouseDragged() {
  // if the mouseY is not over the menu, do dragging
  if (mouseY < 2*height/3 && mouseY > height/3) {
    viewOffset -= 5*(mouseDragXStart-mouseX > 0 ? 1: -1);
  }
}

void mousePressed() {


  // Menu stuff
  menu.handleClicks(mouseX, mouseY);
  // camera stuff
  mouseDragXStart = mouseX;
  mouseDragYStart = mouseY;


  // piece clicking stuff
  clickX = ((mouseX-width/2)/zoomwee)-(viewOffset/zoomwee);
  clickY = ((mouseY-height/2)/zoomwee);
  // it works at any zoom level, but when you pan left or right it breaks
  // therefore the viewOffset componenet of the above formula is wrong in some way
  for (Piece p : puzzle.pieces) {
    // it still slightly not work sometimes???
    if (p.clickCheck(clickX, clickY)) println("clicked on piece " + p.idx + ", which is a " + p.getC() + "c");
  }
}
