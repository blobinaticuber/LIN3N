class NMatrix {

  int[][] elements;
  int size;


  // creates an identity matrix
  NMatrix(int size) {
    this.size = size;
    elements = new int[size][size];
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        elements[i][j] = 0;
        if (i==j) elements[i][j] = 1;
      }
    }
  }

  // creates a matrix given a 2D array
  NMatrix(int size, int[][] e) {
    this.size = size;
    elements = new int[size][size];
    for (int i = 0; i < elements.length; i++) {
      for (int j = 0; j < elements.length; j++) {
        elements[i][j] = e[i][j];
      }
    }
  }
  
  // function for multiplying matrix x vector
  int[] multiply(int[] v) {
    int[] n = new int[v.length];
    
    // 1. multiply each vector in the matrix by the scalars of the vector
    // 2. add up those new rows into a single vector
   
    
    return n;
  }
  
  // helper function to turn a column of a matrix into an int[]
  int[] matrixColumnToVector(NMatrix m, int column) {
    int[] n = new int[m.size];
    for (int i = 0; i < n.length; i++) {
      n[i] = m.elements[i][column];
    }
    return n;
  }
  
  // helper function that scalars a vector
  int[] scaleVector(int[] v, int s) {
    int[] n = new int[v.length];
    for (int i = 0; i < v.length; i++) {
      n[i] = v[i]*s;
    }
    return n;
  }
  
  // helper function that adds 2 vectors
  int[] addVectors(int[] a, int[] b) {
    // assumes a and b are the same size
    int[] n = new int[a.length];
    for (int i = 0; i < b.length; i++) {
      n[i] = a[i] + b[i];
    }
    return n;
  }
  
  // function for multiplying matrix x matrix goes here
  NMatrix multiply(NMatrix n) {
    return n;
  }
  
  


  // prints the matrix to the Console for debugging porpoises
  void printMatrix() {
    for (int i = 0; i < elements.length; i++) {
      for (int j = 0; j < elements.length; j++) {
        print(elements[i][j]);
      }
      println();
    }
  }
  
  int get(int a, int b) {
    return elements[a][b];
  }
  
  void setColumn(int a, int[] v) {
    
  }
}
