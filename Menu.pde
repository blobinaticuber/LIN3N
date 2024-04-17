class Menu {

  int puzzleSize = 1;
  int puzzleSizeMin = 1;
  int puzzleSizeMax = 9;

  int menuPanelWidth;
  int menuPanelHeight;

  Button dimDecrease;
  Button dimIncrease;
  Button resetClickBuffer;

  color progressBarLeftColour;
  color progressBarRightColour;
  color black = color(0, 0, 0);
  color transparent = color(255, 255, 255, 0);
  color buttonColour = color(48);
  color bgColour = color(64);
  color menuPanelColour = color(32);

  color red = color(255, 0, 0);
  color orange = color(255, 128, 0);
  color white = color(255, 255, 255);
  color yellow = color(255, 255, 0);
  color green = color(0, 255, 0);
  color blue = color(0, 128, 255);
  color pink = color(255, 0, 255);
  color purple = color(128, 0, 255);
  color dgrey = color(16, 16, 16);
  color seagreen = color(32, 64, 64);
  color brick = color(128, 0, 0);
  color brown = color(128, 64, 0);
  color dgreen = color(0, 64, 0);
  color dblue = color(0, 0, 128);
  color hotPink = color(255, 0, 128);
  color dpurple = color(128, 0, 128);
  color olive = color(128, 128, 0);
  color navajoWhite = color(255, 222, 173);


  color[] posColours = {red, white, green, pink, seagreen, brick, dgreen, hotPink, olive};
  color[] negColours = {orange, yellow, blue, purple, dgrey, brown, dblue, dpurple, navajoWhite};



  Puzzle puzzle = new Puzzle(puzzleSize);

  Menu() {
    menuPanelWidth = width/3;
    menuPanelHeight = height/3;
    progressBarReset();
  }



  void progressBarReset() {
    progressBarLeftColour = transparent;
    progressBarRightColour = transparent;
  }


  void draw() {
    pushMatrix();
    // translate the puzzle to the center of the screen, plus the offset
    translate(width/2+viewOffset, height/2);
    // translate to where the mouse is, zoom in centered on that
    //translate(mouseX,0);
    scale(abs(zoomwee));
    //scale(abs(zoomwee),1); // this keeps the y-axis the same height, cool squish effect
    //translate(-1*mouseX,0);
    // undo the mouse translation
    puzzle.draw();
    popMatrix();

    menuPanelWidth = width/3;
    menuPanelHeight = height/3;

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
    fill(menuPanelColour);
    rectMode(CORNER);
    rect(0, 0, menuPanelWidth, menuPanelHeight);
    fill(255, 255, 255);
    textSize(48);
    text("Puzzle", 10, 48);
    text("3^" + puzzleSize, 10, 100);

    int buttonWidth = menuPanelWidth/2;
    int buttonHeight = menuPanelHeight/2;
    dimDecrease = new Button(buttonColour, 0, buttonHeight, buttonWidth, buttonHeight, 20);
    dimDecrease.draw();
    dimIncrease = new Button(buttonColour, buttonWidth, buttonHeight, buttonWidth, buttonHeight, 20);
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
    fill(menuPanelColour);
    rectMode(CORNER);
    rect(width/3, 0, menuPanelWidth, menuPanelHeight);
    fill(255, 255, 255);
    textSize(48);
    text("Stats", 10+(width/3), 48);
    // also only start the timer after a twist
    // if puzzle becomes solved, stop the timer lol
    text("time: " + (millis()/1000.0), 10+width/3, 100);
    text("twists: 0", 10+width/3, 200);
  }

  void drawColourMenu() {
    fill(menuPanelColour);
    rectMode(CORNER);
    rect(2*width/3, 0, menuPanelWidth, menuPanelHeight);
    fill(255, 255, 255);
    textSize(48);
    text("Colours", 10+(2*width/3), 48);

    // refactor later to make the boxes uniform
    for (int c = 0; c < puzzle.dim; c++) {
      int cl = puzzle.dim;
      fill(posColours[c]);
      rect(2*width/3 + (c*width/3/cl), height/3/2, width/3/cl, height/3/2/2);
      fill(negColours[c]);
      rect(2*width/3 + (c*width/3/cl), height/3/2+height/3/2/2, width/3/cl, height/3/2/2);
    }
  }


  void drawFiltersMenu() {
    fill(menuPanelColour);
    rectMode(CORNER);
    rect(0, 2*height/3, menuPanelWidth, menuPanelHeight);
    fill(255, 255, 255);
    textSize(48);
    text("Filters", 10, 2*height/3 + 48);
  }

  void drawProgressMenu() {
    fill(menuPanelColour);
    rectMode(CORNER);
    rect(width/3, 2*height/3, menuPanelWidth, menuPanelHeight);
    fill(255, 255, 255);
    textSize(48);
    text("Progress", width/3 + 10, 2*height/3 + 48);
    
    // draws a little red x inside the button
    stroke(255,0,0);
    line(2*menuPanelWidth, 2*menuPanelHeight, (2*menuPanelWidth)-(menuPanelWidth/8), (2*menuPanelHeight)+(menuPanelHeight/8));
    line((2*menuPanelWidth)-(menuPanelWidth/8), 2*menuPanelHeight, 2*menuPanelWidth, (2*menuPanelHeight)+(menuPanelHeight/8));
    stroke(0);
    int buttonH = menuPanelHeight/8;
    int buttonW = menuPanelWidth/8;
    resetClickBuffer = new Button(buttonColour, (2*menuPanelWidth)-(menuPanelWidth/8), 2*menuPanelHeight, buttonW, buttonH, 5);
    resetClickBuffer.draw();
    
    // click progress bar
    fill(transparent);
    rect(width/3 + width/3/8, 2*height/3 + 70, width/3 - 2*width/3/8, 20);

    fill(progressBarLeftColour);
    rect(width/3 + width/3/8, 2*height/3 + 70, (width/3 - 2*width/3/8)/2, 20);

    fill(progressBarRightColour);
    rect(width/3 + width/3/2, 2*height/3 + 70, (width/3 - 2*width/3/8)/2, 20);


    fill(255, 255, 255);
    textSize(20);
    text("Solved pieces: " + puzzle.bulk, width/3 + 10, 2*height/3 + height/3/2);
  }

  void drawControlsMenu() {
    fill(menuPanelColour);
    rectMode(CORNER);
    rect(2*width/3, 2*height/3, menuPanelWidth, menuPanelHeight);
    fill(255, 255, 255);
    textSize(48);
    text("Controls", 2*width/3 + 10, 2*height/3 + 48);
  }


  void handleClicks(float x, float y) {
    // piece clicking stuff
    float clickX = ((mouseX-width/2)/zoomwee)-(viewOffset/zoomwee);
    float clickY = ((mouseY-height/2)/zoomwee);

    if (puzzleSize > 2) {
      for (Piece p : puzzle.pieces) {
        p.clickCheck(clickX, clickY); //println("clicked on piece " + p.idx + ", which is a " + p.getC() + "c");
      }
    }



    if (dimDecrease.clicked(x, y) && puzzle.dim>puzzleSizeMin) {
      puzzleSize--;
      puzzle = new Puzzle(puzzleSize);
      progressBarReset();
    }
    if (dimIncrease.clicked(x, y) && puzzle.dim<puzzleSizeMax) {
      puzzleSize++;
      puzzle = new Puzzle(puzzleSize);
      progressBarReset();
    }
    if (resetClickBuffer.clicked(x, y)) {
      puzzle.resetClickBuffer();
      if (puzzleSize>2) puzzle.adj = new int[2*(puzzleSize) -4];
      progressBarReset();
    }
  }
}
