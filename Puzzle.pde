class Puzzle {

  Piece[] pieces;
  // click buffer will be {clicked piece 1 index, sticker of piece 1 clicked, same for piece 2, etc}
  int[] clickBuffer = new int[4];
  int dim;
  int bulk;
  // bulk is 3^d

  


  Puzzle(int d) {
    // resets the view to the center of the puzzle when making a new puzzle
    viewOffset = 0;
    zoomwee = 1.0;

    dim = d;

    bulk = (int)pow(3, dim);

    pieces = new Piece[bulk];

    // WARNING - it doensn't like this fsr. NullPointerException
    //resetClickBuffer();
    //clickBuffer = new int[] {-1, -1, -1, -1};
    //menu.progressBarLeftColour = menu.transparent;
    //menu.progressBarRightColour = menu.transparent;
    
    println("clicked " + clickBuffer[0] + ", " + clickBuffer[1] + " and " + clickBuffer[2] + ", " + clickBuffer[3]);


    //p goes through all the pieces (3^d)
    for (int p = 0; p < bulk; p++) {

      // make a vector with dimension number of spots
      int[] vec = new int[d];

      for (int v = 0; v < d; v++) {
        // clever thing to get the ijk etc from the loop (see my ms paint drawing)
        vec[d-1-v] = (p/((int)pow(3, v))%3)-1;
      }
      //printArray(vec);
      //print("\n");
      pieces[p] = new Piece(vec, p);
    }
  }


  void draw() {
    for (Piece p : pieces) {
      p.draw();
    }
    //pieces[].draw();
    // for debugging certain pieces, put the index of the piece
  }


  boolean clickBufferEmpty() {
    return (clickBuffer[0] == -1 && clickBuffer[1] == -1 && clickBuffer[2] == -1 && clickBuffer[3] == -1);
  }

  boolean clickBufferFull() {
    return (clickBuffer[0] != -1 && clickBuffer[1] != -1 && clickBuffer[2] != -1 && clickBuffer[3] != -1);
  }

  void resetClickBuffer() {
    menu.progressBarLeftColour = menu.transparent;
    menu.progressBarRightColour = menu.transparent;
    clickBuffer = new int[] {-1, -1, -1, -1};
  }

  void updateClickBuffer(int idx) {
    // I also have to make it bad if the 2nd one in the buffer
    // is not an adjacent 2c on the same side as the first.
    // for right now, it just detects if they're both 2c pieces...
    
    
    if (clickBufferFull()) {
      // do the appropriate twist, then reset buffer
      resetClickBuffer();
      return;
    }

    // if the clickBuffer has something other than -1's in it
    // we'll assume that the first two indices of clickBuffer are a piece
    if (!clickBufferEmpty()) {
      if (pieces[idx].getC() ==2) {
        clickBuffer[2] = idx;
        // also add the sticker clicked to clickBuffer[3];
        menu.progressBarRightColour = menu.green;
      } else {
        menu.progressBarRightColour = menu.red;
      }
    } else {
      if (pieces[idx].getC() ==2) {
        clickBuffer[0] = idx;
        // also add the sticker clicked to clickBuffer[1];
        menu.progressBarLeftColour = menu.green;
      } else {
        menu.progressBarLeftColour = menu.red;
      }
    }
  }
}
