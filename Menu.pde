class Menu {

  int puzzleSize = 2;

  Button dimDecrease;
  Button dimIncrease;

  //MenuPanel[] menuPanels = new MenuPanel[1];


  //Menu() {
  //  MenuPanel PuzzleMenu = new MenuPanel();
  //  menuPanels[0] = PuzzleMenu;

  //}


  void draw() {
    strokeWeight(5);
    pushMatrix();
    translate(0, 0);
    // top 3 menus
    drawPuzzleMenu();
    drawStatsMenu();
    drawColourMenu();
    // bottom 3 menus
    drawFiltersMenu();
    drawProgressMenu();
    drawControlsMenu();
    popMatrix();
  }

  void drawPuzzleMenu() {
    fill(32, 32, 32);
    rectMode(CORNER);
    rect(0, 0, width/3, height/3);
    fill(255, 255, 255);
    textSize(48);
    text("Puzzle", 10, 48);
    text("3^"+puzzle.dim, 10, 100);
    dimDecrease = new Button(color(48), 0, width/3/2, width/3/2, height/3/2);
    dimDecrease.draw();
    dimIncrease = new Button(color(48), width/3/2, width/3/2, width/3/2, height/3/2);
    dimIncrease.draw();
    // minus symbol on top of dimDecrease button
    stroke(255);
    line(width/3/2/3, height/3/2 + (height/3/2/2), 2*width/3/2/3, height/3/2 + (height/3/2/2));
    // plus symbol on top of dimIncrease button
    // horizontal line
    line(width/3/2 + width/3/2/2/2, height/3/2 + (height/3/2/2), width/3/2 + 3*width/3/2/2/2, height/3/2 + (height/3/2/2));
    // vertical line
    line(4.5*width/3/2/3, height/3/2 + (height/3/2/2/2), 4.5*width/3/2/3, height/3/2 + 3*height/3/2/2/2);
    stroke(0);
  }


  void drawStatsMenu() {
    fill(32, 32, 32);
    rectMode(CORNER);
    rect(width/3, 0, width/3, height/3);
    fill(255, 255, 255);
    textSize(48);
    text("Stats", 10+(width/3), 48);
    // if puzzle becomes solved, stop the timer lol
    text("time: " + (millis()/1000.0), 10+width/3, 100);
    text("twists: 0", 10+width/3, 200);
  }

  void drawColourMenu() {
    fill(32, 32, 32);
    rectMode(CORNER);
    rect(2*width/3, 0, width/3, height/3);
    fill(255, 255, 255);
    textSize(48);
    text("Colours", 10+(2*width/3), 48);
    
    // refactor later to make the boxes uniform
    for (int c = 0; c < puzzle.posColours.length; c++) {
      int cl = puzzle.posColours.length;
      fill(puzzle.posColours[c]);
      rect(2*width/3 + (c*width/3/cl), 100, width/3/cl, height/3/cl);
      fill(puzzle.negColours[c]);
      rect(2*width/3 + (c*width/3/cl), 200, width/3/cl, height/3/cl);
    }
  }
  
  
  void drawFiltersMenu() {
    fill(32, 32, 32);
    rectMode(CORNER);
    rect(0, 2*height/3, width/3, height/3);
    fill(255, 255, 255);
    textSize(48);
    text("Filters", 10, 2*height/3 + 48);
    
  }
  
  void drawProgressMenu() {
    fill(32, 32, 32);
    rectMode(CORNER);
    rect(width/3, 2*height/3, width/3, height/3);
    fill(255, 255, 255);
    textSize(48);
    text("Progress", width/3 + 10, 2*height/3 + 48);
    
  }
  
  void drawControlsMenu() {
    fill(32, 32, 32);
    rectMode(CORNER);
    rect(2*width/3, 2*height/3, width/3, height/3);
    fill(255, 255, 255);
    textSize(48);
    text("Controls", 2*width/3 + 10, 2*height/3 + 48);
    
  }


  void handleClicks(float x, float y) {
    if (dimDecrease.clicked(x, y) && puzzle.dim>1) {
      puzzleSize--;
      puzzle = new Puzzle(puzzleSize);
      //println("decrease size");
    }
    if (dimIncrease.clicked(x, y) && puzzle.dim<7) {
      puzzleSize++;
      puzzle = new Puzzle(puzzleSize);
      //println("increase size");
    }
  }

  boolean puzzleMenuClicked(float x, float y) {
    return (x > 0 && x < width/3 && y > 0 && y < height/3);
  }
}
