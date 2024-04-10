class Piece {
  int dim;
  int idx;

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
    translate((width/puzzle.bulk)*(idx-((puzzle.bulk-1)/2)), 0);
    // s is the size to draw the boxes, leaving a gap of 2 on either side
    int s = (width/puzzle.bulk)/((2*dim)+1);
    
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
}
