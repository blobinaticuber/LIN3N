class Puzzle {

  Piece[] pieces;
  int dim;
  int bulk;



  Puzzle(int d) {
    dim = d;
    
    bulk = (int)pow(3,dim);

    pieces = new Piece[(int)pow(3, d)];

    //p goes through all the pieces (3^d)
    for (int p = 0; p < (int)pow(3, d); p++) {

      // make a vector with dimension number of spots
      int[] vec = new int[d];

      for (int v = 0; v < d; v++) {
        // clever thing to get the ijk etc from the loop (see my ms paint drawing)
        vec[v] = (p/((int)pow(3, v))%3)-1;
      }
      //printArray(vec);
      //print("\n");

      pieces[p] = new Piece(new NVector(vec),p);
      //println(p);
    }
  }


  void draw() {
    for (Piece p : pieces) {
      p.draw();
    }
    //pieces[0].draw();
  }
}
