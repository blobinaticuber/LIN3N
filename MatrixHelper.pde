class MatrixHelper {
  // assumes all matrices are square, and all vectors match the length of matrices



  // multiplies two matrices, returning the result matrix
  int[][] multiply(int[][] leftMatrix, int[][] rightMatrix) {
    int[][] returnMatrix = new int[leftMatrix.length][leftMatrix.length];
    int[] leftMatrix_rightMatrixColumnVector = new int[leftMatrix.length];

      for (int j = 0; j < rightMatrix.length; j++) {
        // puts the jth column of right matrix into a column vector
        int[] rightMatrixColumnVector = new int[rightMatrix.length];
        for (int k = 0; k < rightMatrix.length; k++) {
          rightMatrixColumnVector[k] = rightMatrix[k][j];
        }
        leftMatrix_rightMatrixColumnVector = multiply(leftMatrix, rightMatrixColumnVector);
        //printArray(leftMatrix_rightMatrixColumnVector);
        for (int l = 0; l < rightMatrix.length; l++) {
          returnMatrix[l][j] = leftMatrix_rightMatrixColumnVector[l];
        }
      }



    return returnMatrix;
  }


  // multiplies a matrix and a vector, returning the result vector
  int[] multiply(int[][] matrix, int[] vector) {
    int[] returnVector = new int[vector.length];
    for (int i = 0; i < vector.length; i++) {
      int row = 0;
      for (int j = 0; j < vector.length; j++) {
        row += (matrix[i][j] * vector[j]);
      }
      returnVector[i] = row;
    }
    return returnVector;
  }





  int[][] identity(int size) {
    int[][] returnMatrix = new int[size][size];
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        returnMatrix[i][j] = 0;
        if (i==j) returnMatrix[i][j] = 1;
      }
    }
    return returnMatrix;
  }




  // functions to get rotation matrices:
  
  int[][] getRotationMatrix(int c1, int c2) {
    int[][] matthew = identity(menu.puzzleSize);
    if (c1 == c2) {
      println("error! cannot swap column with itself");
      return matthew;
    } else {
    // need to swap from and to columns of identity
    // then need to invert the one where from goes to after swap (invert c2)
    
    int[] temp = new int[menu.puzzleSize];
    
    for (int i = 0; i < temp.length; i++) {
      temp[i] = matthew[c1][i];
    }
    for (int j = 0; j < temp.length; j++) {
      matthew[c1][j] = matthew[c2][j];
    }
    for (int k = 0; k < temp.length; k++) {
      matthew[c2][k] = temp[k]*(-1);
    }
    return matthew;
    }
    
  }


  // prints the matrix to the Console for debugging porpoises
  void printMatrix(int[][] matrix) {
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix.length; j++) {
        print(matrix[i][j] + " ");
      }
      println();
    }
  }

  void printVector(int[] vector) {
    for (int i = 0; i < vector.length; i++) {
      println(vector[i]);
    }
  }
}
