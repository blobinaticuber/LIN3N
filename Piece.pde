class Piece {
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
      color c1 = red;
      color c2 = red;
      if (d==1) {
        if (position.get(0)==0) fill(transparent);
        if (position.get(0)==1) fill(red);
        if (position.get(0)==-1) fill(orange);
        rect(0, 0, s, s);
      } else {
        if (position.get(d-1)==0) {
          c1 = transparent;
          c2 = transparent;
        }
        else if (position.get(d-1)==1) {
          c1 = posColours[d-1];
          c2 = transparent;
        }
        else if (position.get(d-1)==-1) {
          c1 = transparent;
          c2 = negColours[d-1];
        }
        fill(c1);
        rect(s*(d-1), 0, s, s);
        fill(c2);
        rect(s*(-1*(d-1)), 0, s, s);
      }
    }

    popMatrix();
  }
}
