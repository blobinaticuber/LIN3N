// 1D 3^n simulator??
// By le epic Rowan Fortier (tm)
// Copyright 2024 Hypercubers

int viewOffset = 0;
float zoomwee = 1.0;
float mouseDragStart = 0.0;

void setup() {
  size(800, 800, P3D);
  surface.setLocation(100, 100);
}

Puzzle puzzle = new Puzzle(3);




void draw() {
  background(64);
  drawDebugText();
  translate(width/2+viewOffset, height/2);
  pushMatrix();
  scale(abs(zoomwee));
  puzzle.draw();
  popMatrix();
}

void drawDebugText() {
  fill(255, 255, 255);
  textSize(24);
  text("Puzzle: 3^" + puzzle.dim, 10, 24);
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
  viewOffset -= 5*(mouseDragStart-mouseX > 0 ? 1: -1);
}

void mousePressed() {
  mouseDragStart = mouseX;
}
