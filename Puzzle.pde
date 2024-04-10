class Puzzle {

  Piece[] pieces;
  int dim;
  int bulk;
  // bulk is 3^d
  
  color core = color(0, 0, 0);
  color red = color(255, 0, 0);
  color orange = color(255, 128, 0);
  color white = color(255, 255, 255);
  color yellow = color(255, 255, 0);
  color green = color(0, 255, 0);
  color blue = color(0, 0, 255);
  color pink = color(255, 0, 255);
  color purple = color(128, 0, 255);
  color transparent = color(255, 255, 255, 0);

  color[] posColours = {red, white, green, pink};
  color[] negColours = {orange, yellow, blue, purple};



  Puzzle(int d) {
    dim = d;
    
    bulk = (int)pow(3,dim);

    pieces = new Piece[bulk];

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
      pieces[p] = new Piece(new NVector(vec),p);
    }
  }


  void draw() {
    for (Piece p : pieces) {
      p.draw();
    }
    //pieces[].draw();
    // for debugging certain pieces, put the index of the piece
  }
}
