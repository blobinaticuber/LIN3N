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
    wasClicked = false;
  }

  // draw ALL of the sticker of the piece
  void draw() {
    rectMode(CENTER);
    strokeWeight(1);
    stroke(menu.black);

    if (menu.puzzle.clickBuffer[0] == idx || menu.puzzle.clickBuffer[2] == idx) {
      stroke(menu.white);
      strokeWeight(5);
    }

    //if (idx == puzzle.clickedPieces[0] || idx == puzzle.clickedPieces[1]) {
    //  stroke(puzzle.white);
    //  strokeWeight(5);
    //}

    pushMatrix();
    //translate to x sticker of piece

    xStickerCenterCoordinate = (width/(menu.puzzle.bulk/(int)pow(3, dim-1)))*(idx-((menu.puzzle.bulk-1)/2));
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
    int s = (width/(menu.puzzle.bulk/(int)pow(3, dim-1)))/((2*dim)+1);

    for (int d = 1; d < dim+1; d++) {
      color c1 = menu.transparent;
      color c2 = menu.transparent;
      if (d==1) {
        if (vec_position[0]==0) fill(menu.transparent);
        if (vec_position[0]==1) fill(menu.red);
        if (vec_position[0]==-1) fill(menu.orange);
        rect(0, 0, s, s);
      } else {
        if (vec_position[d-1]==1) c1 = menu.posColours[d-1];
        else if (vec_position[d-1]==-1) c2 = menu.negColours[d-1];
        // draw 2 squares for the + and - axis stickers
        fill(c1);
        rect(s*(d-1), 0, s, s);
        fill(c2);
        rect(s*(-1*(d-1)), 0, s, s);
      }
    }

    popMatrix();
    strokeWeight(1);
    stroke(menu.black);
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

  // changes wasClicked to true if the piece was clicked on
  boolean clickCheck(float clickX, float clickY) {
    // s is the size of the sticker rects of each piece
    int s = (width/(menu.puzzle.bulk/(int)pow(3, dim-1)))/((2*dim)+1);
    if (clickX < xStickerCenterCoordinate+(s/2) && clickX > xStickerCenterCoordinate-(s/2)) {
      if (clickY < (s/2) && clickY > (-1)*(s/2)) {
        menu.puzzle.updateClickBuffer(idx);
        //println("clicked " + puzzle.clickedPieces[0] + " and " + puzzle.clickedPieces[1]);
        println("clicked " + menu.puzzle.clickBuffer[0] + ", " + menu.puzzle.clickBuffer[1] + " and " + menu.puzzle.clickBuffer[2] + ", " + menu.puzzle.clickBuffer[3]);
        wasClicked = true;
        return true;
      }
    }
    // if the user clicked in empty space, empty click buffer
    //puzzle.resetClickBuffer();
    wasClicked = false;
    return false;
  }
}
