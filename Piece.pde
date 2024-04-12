class Piece {
  int dim;
  int idx;
  boolean wasClicked;
  int xStickerCenterCoordinate;

  //Matrix orientation = new Matrix
  NVector position;

  Piece(NVector p, int idx) {
    position = p;
    dim = p.length;
    this.idx = idx;
  }

// draw ALL of the sticker of the piece
  void draw() {
    rectMode(CENTER);
    strokeWeight(1);
    pushMatrix();
    //translate to x sticker of piece
    
    xStickerCenterCoordinate = (width/(puzzle.bulk/(int)pow(3,dim-1)))*(idx-((puzzle.bulk-1)/2));
    //println(xStickerCenterCoordinate);
    
    translate(xStickerCenterCoordinate, 0);
    // s is the size to draw the boxes, leaving a gap of 2 on either side
    int s = (width/(puzzle.bulk/(int)pow(3,dim-1)))/((2*dim)+1);
    
    for (int d = 1; d < dim+1; d++) {
      color c1 = puzzle.transparent;
      color c2 = puzzle.transparent;
      if (d==1) {
        if (position.get(0)==0) fill(puzzle.transparent);
        if (position.get(0)==1) fill(puzzle.red);
        if (position.get(0)==-1) fill(puzzle.orange);
        rect(0, 0, s, s);
      } else {
        if (position.get(d-1)==1) c1 = puzzle.posColours[d-1];
        else if (position.get(d-1)==-1) c2 = puzzle.negColours[d-1];
        // draw 2 squares for the + and - axis stickers
        fill(c1);
        rect(s*(d-1), 0, s, s);
        fill(c2);
        rect(s*(-1*(d-1)), 0, s, s);
      }
    }

    popMatrix();
  }
  
  // returns the number of colours a piece has
  int getC() {
    int r = 0;
    for (int a = 0; a < dim; a++) {
      r += abs(position.get(a));
    }
    return r;
  }
  
  boolean clickCheck(float clickX, float clickY) {
    int s = (width/puzzle.bulk)/((2*dim)+1);
    if (clickX < xStickerCenterCoordinate+(s/2) && clickX > xStickerCenterCoordinate-(s/2)) {
      if (clickY < (s/2) && clickY > (-1)*(s/2)) {
        return true;
      }
    } 
    return false;
    
  }
  
  
}
