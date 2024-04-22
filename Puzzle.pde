class Puzzle {

  Piece[] pieces;
  // click buffer will be {clicked piece 1 index, sticker of piece 1 clicked, same for piece 2, etc}
  int[] clickBuffer = new int[4];
  int[] adj;
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

    clickBuffer = new int[] {-1, -1, -1, -1};
    
    if (d>2) adj = new int[2*(dim) -4];

    printClickBuffer();


    //p goes through all the pieces (3^d)
    for (int p = 0; p < bulk; p++) {

      // make a vector with dimension number of spots
      int[] vec = new int[d];

      for (int v = 0; v < d; v++) {
        // clever thing to get the ijk etc from the loop (see my ms paint drawing)
        vec[d-1-v] = (p/((int)pow(3, v))%3)-1;
      }
      pieces[p] = new Piece(vec, p);
    }
  }


  void draw() {
    for (Piece p : pieces) {
      p.draw();
    }
  }


  // it works for everything but clicking orange and red rn
  int[] getAdj2C(int idx, int sticker) {
    int[] adj2cList = new int[0]; //= new int[(2*dim) -4];
    int axis = abs(sticker);
    int stickerSign = 0; // is the sticker negative or positive
    if (sticker > 0) stickerSign = 1;
    if (sticker < 0) stickerSign = -1;
    println("stickersigh: " + stickerSign);
    int[] clickedPiecePosition = pieces[idx].position;
    int oppositePieceIdx = -47; // some random defualt value
    
    
    int[] allCell2c = new int[(2*dim)-2];
    int a = 0;
    // looping through all pieces, 
    for (int i = 0; i < bulk-1; i++) {
      // 2c piece AND 
      if (pieces[i].getC() == 2 && pieces[i].position[axis] == stickerSign) {
        allCell2c[a] = pieces[i].idx;
        a++;
      }
    }
    println(allCell2c);
    
    // once we have an array of all the 2c on that cell




    //for (Piece p : pieces) {
    //  //for (int h = 0; h < clickedPiecePosition.length; h++) {
    //  //  if ((p.position[h] == 1 && clickedPiecePosition[h] == -1) || (p.position[h] == -1 && clickedPiecePosition[h] == 1)) {
    //  //    oppositePieceIdx = p.idx;
          
    //  //  }
    //  //}

      
    //  // if 2c and on the same cell and not the clicked 2c and not the opposite 2c
    //  if (p.getC() == 2 && (p.position[axis] == stickerSign) && (p.position != clickedPiecePosition) && p.idx != oppositePieceIdx) {
    //    adj2cList = append(adj2cList, p.idx);
    //    p.highlighted = true;
    //  }
    //}
    //println("oppositePieceIdx: "+oppositePieceIdx);
    //matrixHelper.printVector(adj2cList);
    return adj2cList;
  }


  boolean clickBufferEmpty() {
    return (clickBuffer[0] == -1 && clickBuffer[1] == -1 && clickBuffer[2] == -1 && clickBuffer[3] == -1);
  }

  boolean clickBufferFull() {
    return (clickBuffer[0] != -1 && clickBuffer[2] != -1);
  }

  boolean clickBufferHas(int idx) {
    return (clickBuffer[0] == idx || clickBuffer[2] == idx);
  }
  
  boolean adjHas(int idx) {
    boolean has = false;
    for (int i = 0; i < adj.length; i++) {
      if (adj[i] == idx) {
       has = true;
       break;
      }
    }
    return has;
  }
  
  boolean adjEmpty() {
    boolean has = false;
    for (int i = 0; i < adj.length; i++) {
       has = (adj[i] == 0);
    }
    return has;
  }

  void resetClickBuffer() {
    menu.progressBarLeftColour = menu.transparent;
    menu.progressBarRightColour = menu.transparent;
    clickBuffer = new int[] {-1, -1, -1, -1};
  }

  void printClickBuffer() {
    println("clickBuffer: " + clickBuffer[0] + ", " + clickBuffer[1] + ", " + clickBuffer[2] + ", " + clickBuffer[3]);
  }

  void updateClickBuffer(int idx, int sticker, boolean stickerLegitimacy) {
    
    if (pieces[idx].getC() != 2) {
      println("ERROR: cannot add non-2c piece to clickBuffer");
      printClickBuffer();
      return;
    }
    if (clickBuffer[0] == idx) {
      println("ERROR: cannot click the same piece twice");
      printClickBuffer();
      return;
    }
    if (!stickerLegitimacy) {
      println("ERROR: cannot add piece to clickBuffer because clicked sticker does not exist");
      printClickBuffer();
      return;
    }
    if (clickBufferEmpty()) {
      clickBuffer[0] = idx;
      clickBuffer[1] = sticker;
      adj = getAdj2C(clickBuffer[0], clickBuffer[1]);
      printClickBuffer();
      menu.progressBarLeftColour = menu.green;
      return;
    }
    boolean p2isAdj = false;
    for (int t = 0; t < adj.length; t++) {
      if (adj[t] == idx) {
        p2isAdj = true;
        break;
      }
    }
    if (!p2isAdj) {
      println("ERROR: that 2c is not adjacent");
      return;
    }
    if (clickBuffer[1] != sticker) {
      println("ERROR: must click same sticker of 2nd piece as first piece");
      menu.progressBarRightColour = menu.red;
      return;
    }
    
    //adj = new int[2*(dim) -4];
    clickBuffer[2] = idx;
    clickBuffer[3] = sticker;
    printClickBuffer();

    if (clickBufferFull()) {
      // do the appropriate twist, then reset buffer
      println("DOING A TWIST!!!!!");
      resetClickBuffer();
      printClickBuffer();
      return;
    }


  }
}
