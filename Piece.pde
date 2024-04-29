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
  color[] pColours;
  color[] nColours;

  boolean highlighted = false;

  Piece(int[] p, int idx) {
    dim = p.length;
    this.idx = idx;
    position = new int[dim];
    for (int a = 0; a < dim; a++) {
      position[a] = p[a];
    }

    pColours = new color[dim];
    nColours = new color[dim];

    orientation = matrixHelper.identity(dim);


    s = (width/((int)pow(3, dim)/(int)pow(3, dim-1)))/((2*dim)+1);
    xStickerCenterCoordinate = (width/((int)pow(3, dim)/(int)pow(3, dim-1)))*(idx-(((int)pow(3, dim)-1)/2));
    pieceLeftmostCoordinate = (xStickerCenterCoordinate+(s/2))+(s*(dim-1));
    pieceRightmostCoordinate = (xStickerCenterCoordinate-(s/2))-(s*(dim-1));
  }


  void move(int[][] m) {
    orientation = matrixHelper.multiply(orientation, m);
  }

  int[] getPos() {
    return matrixHelper.multiply(orientation, position);
  }

  // draw ALL of the stickers of the piece
  void draw() {
    rectMode(CENTER);
    strokeWeight(1);
    stroke(menu.black);

    if (dim>2) {
      // if the piece is in the clickBuffer, draw it with a big white outline
      if (menu.puzzle.clickBufferHas(idx)) {
        stroke(menu.white);
        strokeWeight(5);
        // if the piece is in the adjacent 2c buffer, draw it with yellow outline
      } else if (menu.puzzle.adjHas(idx) && !menu.puzzle.adjEmpty()) {
        stroke(menu.yellow);
        strokeWeight(5);
      }
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


    //int[] x = new int[dim];
    //x[0] = 1;

    for (int i = 0; i < dim; i++) {
      color LC = menu.transparent;
      color RC = menu.transparent;
      if (getPos()[i] == 1) {
        LC = menu.transparent;
        RC = menu.posColours[i];
      }
      if (getPos()[i] == -1) {
        LC = menu.negColours[i];
        RC = menu.transparent;
      }
      int[] stickerStart = new int[dim];
      stickerStart[i] = 1;
      int[] stickerWent = matrixHelper.multiply(orientation, stickerStart);
      // if the sticker went to the x axis
      if (Arrays.equals(stickerWent, stickerStart) ) {
        if (getPos()[0]==-1) fill(menu.negColours[0]);
        if (getPos()[0]==0) fill(menu.transparent);
        if (getPos()[0]==1) fill(menu.posColours[0]);
        rect(0, 0, s, s);
      }
      fill(RC);
      rect(s*(i), 0, s, s);
      fill(LC);
      rect(s*(-1*(i)), 0, s, s);
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

  boolean clickCheck(float clickX, float clickY) {
    highlighted = false;
    boolean stickerLegitimacy = false;
    if (clickX < pieceLeftmostCoordinate && clickX > pieceRightmostCoordinate) {
      if (clickY < (s/2) && clickY > (-1)*(s/2)) {
        int sticker = 0;
        for (int n = (-1*dim); n < dim+1; n++) {
          if (clickX < (xStickerCenterCoordinate + (n*s)) + (s/2) && clickX > (xStickerCenterCoordinate + (n*s)) - (s/2)) {
            sticker = n;
          }
        }
        // the sticker they clicked is legitimate if its 1 or -1 in the vector
        if (position[abs(sticker)] != 0) {
          stickerLegitimacy = true;
          stickerLegitimacy = ((position[abs(sticker)] > 0 && sticker >= 0 ) || (position[abs(sticker)] < 0 && sticker <= 0 ));
        }
        println();
        println("clicked " + idx + ", " + sticker);
        menu.puzzle.updateClickBuffer(idx, sticker, stickerLegitimacy);
        return true;
      }
    }
    return false;
  }
}
