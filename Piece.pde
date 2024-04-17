class Piece {
  int dim;
  int idx;
  int xStickerCenterCoordinate;
  // s is the size to draw the boxes, leaving a gap of 2 on either side
  int s;
  int pieceLeftmostCoordinate;
  int pieceRightmostCoordinate;

  int[][] orientation;
  int[] position;

  Piece(int[] p, int idx) {
    position = new int[p.length];
    for (int a = 0; a < p.length; a++) {
      position[a] = p[a];
    }
    orientation = matrixHelper.identity(dim);
    dim = p.length;
    //orientation = new NMatrix(dim);
    this.idx = idx;

    s = (width/((int)pow(3, dim)/(int)pow(3, dim-1)))/((2*dim)+1);
    xStickerCenterCoordinate = (width/((int)pow(3, dim)/(int)pow(3, dim-1)))*(idx-(((int)pow(3, dim)-1)/2));
    pieceLeftmostCoordinate = (xStickerCenterCoordinate+(s/2))+(s*(dim-1));
    pieceRightmostCoordinate = (xStickerCenterCoordinate-(s/2))-(s*(dim-1));
  }

  // draw ALL of the sticker of the piece
  void draw() {
    rectMode(CENTER);
    strokeWeight(1);
    stroke(menu.black);

    // if the piece is in the clickBuffer, draw it with a bigger outline
    if (menu.puzzle.clickBufferHas(idx)) {
      stroke(menu.white);
      strokeWeight(5);
    }

    pushMatrix();

    // if the x sticker of the piece would be draw offscreen, don't draw it lol
    // offscreen culling not quite working, but pretty close!
    //if (abs(zoomwee)*(pieceLeftmostCoordinate+viewOffset) > abs(zoomwee)*((width/2)+viewOffset) || abs(zoomwee)*(pieceRightmostCoordinate+viewOffset) < abs(zoomwee)*((-1*(width/2)+viewOffset))) {
    //  popMatrix();
    //  return;
    //}


    //translate to x sticker of piece
    translate(xStickerCenterCoordinate, 0);


    for (int d = 1; d < dim+1; d++) {
      color c1 = menu.transparent;
      color c2 = menu.transparent;
      if (d==1) {
        if (position[0]==0) fill(menu.transparent);
        if (position[0]==1) fill(menu.red);
        if (position[0]==-1) fill(menu.orange);
        rect(0, 0, s, s);
      } else {
        if (position[d-1]==1) c1 = menu.posColours[d-1];
        else if (position[d-1]==-1) c2 = menu.negColours[d-1];
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
      r += abs(position[a]);
    }
    return r;
  }

  int[] getPos() {
    return matrixHelper.multiply(orientation, position);
  }

  // changes wasClicked to true if the piece was clicked on
  boolean clickCheck(float clickX, float clickY) {
    boolean stickerLegitimacy = false;
    if (clickX < pieceLeftmostCoordinate && clickX > pieceRightmostCoordinate) {
      if (clickY < (s/2) && clickY > (-1)*(s/2)) {
        int sticker = 0;
        for (int n = (-1*dim); n < dim+1; n++) {
          if (clickX < (xStickerCenterCoordinate + (n*s)) + (s/2) && clickX > (xStickerCenterCoordinate + (n*s)) - (s/2)) {
            sticker = n;
          }
        }

        stickerLegitimacy = (position[abs(sticker)] != (sticker>0 ? 1 : -1));


        println("you clicked piece " + idx + ", sticker " + sticker);
        //println("adjacent 2c's:");
        //matrixHelper.printVector(menu.puzzle.getAdj2C(idx, sticker));
        menu.puzzle.updateClickBuffer(idx, sticker, stickerLegitimacy);
        return true;
      }
    }
    return false;
  }
}
