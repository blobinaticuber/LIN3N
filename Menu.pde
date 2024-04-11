class Menu {
  
  int puzzleSize = 2;

  Button dimDecrease;
  Button dimIncrease;


  void draw() {
    pushMatrix();
    translate(0, 0);
    drawPuzzleMenu();
    popMatrix();
    
    dimDecrease = new Button(color(48),0,width/3/2,width/3/2,height/3/2,"-");
    dimDecrease.draw();
    dimIncrease = new Button(color(48),width/3/2,width/3/2,width/3/2,height/3/2,"+");
    dimIncrease.draw();
    
  }

  void drawPuzzleMenu() {
    fill(32, 32, 32);
    rectMode(CORNER);
    rect(0, 0, width/3, height/3);
    fill(255,255,255);
    textSize(48);
    text("Puzzle",10,48);
    text("3^"+puzzle.dim,10,100);
    //fill(48);
    
    
    
    
  }
  
  void handleClicks(float x, float y) {
    //if (puzzleMenuClicked(x,y)) puzzle = new Puzzle(puzzleSize++);
    if (dimDecrease.clicked(mouseX, mouseY) && puzzle.dim>1) puzzle = new Puzzle(puzzleSize--);
    if (dimIncrease.clicked(mouseX, mouseY)) puzzle = new Puzzle(puzzleSize++);
  }
  
  boolean puzzleMenuClicked(float x, float y) {
    return (x > 0 && x < width/3 && y > 0 && y < height/3);
  }
}
