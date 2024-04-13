class Piece {
  int dim;
  int idx;
  boolean wasClicked;
  int xStickerCenterCoordinate;

  NMatrix orientation;
  int[] vec_position;

  Piece(int[] p, int idx) {
    vec_position = new int[p.length];
    for (int a = 0; a < p.length; a++) {
      vec_position[a] = p[a];
    }
    dim = p.length;
    orientation = new NMatrix(dim);
    this.idx = idx;
  }

  // draw ALL of the sticker of the piece
  void draw() {
    rectMode(CENTER);
    strokeWeight(1);
    stroke(puzzle.black);
    //if (idx == puzzle.clickedPieces[0] || idx == puzzle.clickedPieces[1]) {
    //  stroke(puzzle.white);
    //  strokeWeight(5);
    //}

    pushMatrix();
    //translate to x sticker of piece

    xStickerCenterCoordinate = (width/(puzzle.bulk/(int)pow(3, dim-1)))*(idx-((puzzle.bulk-1)/2));
    // if the x sticker of the piece would be draw offscreen, don't draw it lol
    //int xscc2 = xStickerCenterCoordinate*(int)zoomwee + (viewOffset*(int)zoomwee);
    
    // offscreen culling not quite working, but pretty close!
    int xscc2 = (int)zoomwee*(xStickerCenterCoordinate+viewOffset);
    if (xscc2 > width/2 || xscc2 < 0-width/2) {
      popMatrix();
      return;
    }
      
    
    //println(xStickerCenterCoordinate);

    translate(xStickerCenterCoordinate, 0);
    // s is the size to draw the boxes, leaving a gap of 2 on either side
    int s = (width/(puzzle.bulk/(int)pow(3, dim-1)))/((2*dim)+1);

    for (int d = 1; d < dim+1; d++) {
      color c1 = puzzle.transparent;
      color c2 = puzzle.transparent;
      if (d==1) {
        if (vec_position[0]==0) fill(puzzle.transparent);
        if (vec_position[0]==1) fill(puzzle.red);
        if (vec_position[0]==-1) fill(puzzle.orange);
        rect(0, 0, s, s);
      } else {
        if (vec_position[d-1]==1) c1 = puzzle.posColours[d-1];
        else if (vec_position[d-1]==-1) c2 = puzzle.negColours[d-1];
        // draw 2 squares for the + and - axis stickers
        fill(c1);
        rect(s*(d-1), 0, s, s);
        fill(c2);
        rect(s*(-1*(d-1)), 0, s, s);
      }
    }

    popMatrix();
    strokeWeight(1);
    stroke(puzzle.black);
  }

  // returns the number of colours a piece has
  int getC() {
    int r = 0;
    for (int a = 0; a < dim; a++) {
      r += abs(vec_position[a]);
    }
    return r;
  }

  int[] getPos() {
    return orientation.multiply(vec_position);
  }

  boolean clickCheck(float clickX, float clickY) {
    // s is the size of the sticker rects of each piece
    int s = (width/(puzzle.bulk/(int)pow(3, dim-1)))/((2*dim)+1);
    if (clickX < xStickerCenterCoordinate+(s/2) && clickX > xStickerCenterCoordinate-(s/2)) {
      if (clickY < (s/2) && clickY > (-1)*(s/2)) {
        // bad code to add what piece you clicked on to a list
        // will redo this, but using clickBuffer[] later!!
        
        //if (puzzle.clickedPieces[0] > -1 && puzzle.clickedPieces[1] > -1) {
        //  puzzle.clickedPieces[0] = -1;
        //  puzzle.clickedPieces[1] = -1;
        //} else if (puzzle.clickedPieces[0] == -1) {
        //  puzzle.clickedPieces[0] = idx;
        //} else if (puzzle.clickedPieces[0] > -1 && puzzle.clickedPieces[1] == -1){
        //  puzzle.clickedPieces[1] = idx;
        //}
         
        //println("clicked " + puzzle.clickedPieces[0] + " and " + puzzle.clickedPieces[1]);
        println("clicked " + puzzle.clickBuffer[0] + ", " + puzzle.clickBuffer[1] + " and " + puzzle.clickBuffer[2] + ", " + puzzle.clickBuffer[3]);
        wasClicked = true;
        return true;
      }
    }
    wasClicked = false;
    return false;
  }
}
