class Minehunter {
  int numRow = 8;
  int numCol = 8;
  int numMines = 8;
  boolean board[][] = new boolean[numRow][numCol];
  //ArrayList<String> mines = new ArrayList<String>();
  //ArrayList<String> minesFound = new ArrayList<String>();
  ArrayList<PVector> mines = new ArrayList<PVector>();
  ArrayList<PVector> minesFound = new ArrayList<PVector>();
  ArrayList<PVector> flags = new ArrayList<PVector>();

  PImage flagImg = loadImage("flag.png");

  Player player;
  Reward reward;

  Minehunter() {
    player = new Player();
    reward = new Reward();

    // Initializing gameboard with no mine
    for (int i=0; i<numRow; i++) {
      for (int j=0; j<numCol; j++) {
        board[i][j] = false;
      }
    }

    // Formula for encoding coordinates:
    // (i, j): i = row coordinate, j = col coordinate
    // i, j <= 7 so can encoding in the form 'ij'
    // e.g. '56' = (5, 6) = row 5, col 6

    // Adding random mines (max 8) to gameboard
    while (mines.size() != numMines) {
      int i = int(random(numRow));
      int j = int(random(numCol));
      if (board[i][j] == false) {
        board[i][j] = true;
        PVector coordinates = new PVector(i, j);
        mines.add(coordinates);
      }
    }
  }

  int numNeighborMines(int row, int col) {
    int count = 0;
    for (int i=row-1; i<row+2; i++) {
      for (int j=col-1; j<col+2; j++) {
        if (i==row && j==col) {
          continue;
        } else {
          if (0 <= i && i < numRow && 0 <= j && j < numCol) {
            if (board[i][j] == true) {
              count += 1;
            }
          }
        }
      }
    }
    return count;
  }

  void changeFlag() {
    PVector coordinates = new PVector(player.i, player.j);
    if (!flags.contains(coordinates)) {
      flags.add(coordinates);
    }
    else {
      flags.remove(coordinates);
    }
  }

  void displayFlags() {
    for (PVector flag : flags) {
      imageMode(CENTER);
      float x = (flag.x + 0.5) * cellSize;
      float y = (flag.y + 0.5) * cellSize;
      image(flagImg, x, y, cellSize, cellSize);
    }
  }

  boolean isMine(int i, int j) {
    return board[i][j];
  }

  boolean gameWon() {
    return minesFound.size() == mines.size();
  }

  void displayBoard() {
    pushMatrix();
    translate(padding, padding);
    for (int i=0; i<boardDim; i++) {
      for (int j=0; j<boardDim; j++) {
        stroke(255);
        strokeWeight(2);
        //if (showingMines == true && minehunter.isMine(i, j)) {
        //  fill(tmpBomb);
        //} else {
        fill(cellColor);
        //}
        rect(i*cellSize, j*cellSize, cellSize, cellSize);
        fill(tmpBomb);
        rect(player.i*cellSize, player.j*cellSize, cellSize, cellSize);
      }
    }
    popMatrix();
  }

  void displayGame() {
    displayBoard();
    displayFlags();
    player.displayPlayer();
    reward.displayReward();
  }

  //void keyPressed() {
  //  if (keyPressed) {
  //    if (key == 'f' || key == 'F') {
  //      addFlag();
  //    }
  //  }
  //}

  /**
   * Print a textual form of the board
   * For testing purposes
   */
  void printBoard() {
    for (int i=0; i<numRow; i++) {
      for (int j=0; j<numCol; j++) {
        if (board[i][j] == true) {
          print("X");
        } else {
          print("_");
        }
      }
      println();
    }
  }

  //String tupleToString(int i, int j) {
  //  return str(i)+str(j);
  //}

  ///**
  //* Coordinate in the form of 'ij'
  //* i = ij / 10
  //*/
  //int stringToX(String coordinate) {
  //  return int(int(coordinate) / 10);
  //}

  //int stringToY(String coordinate) {
  //  return int(int(coordinate) % 10);
  //}

  void testMinehunter() {
    //println(stringToX("00"), stringToY("00"));
    //println(numNeighborMines(4, 4));
  }
}
