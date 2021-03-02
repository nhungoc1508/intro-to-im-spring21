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
  ArrayList<PVector> revealed = new ArrayList<PVector>();

  float buttonWidth;

  PImage flagImg = loadImage("flag.png");
  PImage mineImg = loadImage("mine.png");
  PImage bg = loadImage("tile0.png");

  Player player0, player;
  Reward reward;


  Minehunter() {
    player0 = new Player();
    player = new Player();
    reward = new Reward();

    textSize(height*.05);
    buttonWidth = textWidth("NEW GAME");

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
      if (isMine(player.i, player.j)) {
        if (!minesFound.contains(coordinates)) {
          minesFound.add(coordinates);
        }
      }
    } else {
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

  void revealCell() {
    if (!isMine(player.i, player.j)) {
      PVector coordinates = new PVector(player.i, player.j);
      if (!revealed.contains(coordinates)) {
        revealed.add(coordinates);
        reward.collectReward();
      }
    } else { // dummy function for now
      displayMines();
    }
  }

  void displayRevealedCells() {
    for (PVector cell : revealed) {
      int i = int(cell.x);
      int j = int(cell.y);
      if (i == player.i && j == player.j) {
        pushMatrix();
        translate(cellSize*.5, cellSize*.5);
        fill(0);
        textSize(cellSize*.4);
        textAlign(CENTER, CENTER);
        text(str(numNeighborMines(i, j)), i*cellSize, j*cellSize);
        popMatrix();
      }
    }
  }

  void displayMines() {
    for (PVector mine : mines) {
      imageMode(CENTER);
      float x = (mine.x + 0.5) * cellSize;
      float y = (mine.y + 0.5) * cellSize;
      image(mineImg, x, y, cellSize, cellSize);
    }
  }

  boolean isMine(int i, int j) {
    return board[i][j];
  }

  boolean gameWon() {
    return minesFound.size() == mines.size();
  }

  void displayBackground() {
    pushMatrix();
    translate(padding, padding);
    for (int i=0; i<boardDim; i++) {
      for (int j=0; j<boardDim; j++) {
        stroke(255);
        strokeWeight(2);
        imageMode(CENTER);
        image(bg, (i+0.5)*cellSize, (j+0.5)*cellSize, cellSize, cellSize);
      }
    }
    popMatrix();
  }

  void displayBoard() {
    pushMatrix();
    translate(padding, padding);
    for (int i=0; i<boardDim; i++) {
      for (int j=0; j<boardDim; j++) {
        stroke(255);
        strokeWeight(2);
        imageMode(CENTER);
        fill(cellColor);
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
    displayRevealedCells();
    if (!gameWon()) {
      player.movePlayer();
    }
    player.displayPlayer();
    reward.displayReward();
    if (gameWon()) {
      screen = "win";
    }
  }

  void displayWelcome() {
    // Game name
    fill(255);
    rect(0, 0, width, height);
    fill(0);
    textSize(height*.1);
    textAlign(CENTER, CENTER);
    text("MINEHUNTER", width/2, height/3);

    // Animated avatar
    player0.x = width/2;
    player0.y = height/2;
    player0.displayPlayer();
    player0.autoMove = true;
    player0.movePlayer();

    // Buttons
    String howto = "HOW TO";
    String start = "START";
    pushStyle();
    noStroke();
    textSize(height*.05);
    //float buttonWidth = textWidth(howto);
    rectMode(CENTER);

    PShape howtoButton = createShape(RECT, width/2, height*.75, buttonWidth*1.2, buttonWidth*.3);
    howtoButton.setFill(0);
    shape(howtoButton);

    PShape startButton = createShape(RECT, width/2, height*.85, buttonWidth*1.2, buttonWidth*.3);
    startButton.setFill(0);
    shape(startButton);
    popStyle();

    // Event: pressing How To button
    float leftHowtoButton = width/2 - buttonWidth*1.2*.5;
    float rightHowtoButton = width/2 + buttonWidth*1.2*.5;
    float topHowtoButton = height*.75 - buttonWidth*.3*.5;
    float bottomHowtoButton = height*.75 + buttonWidth*.3*.5;
    if (leftHowtoButton <= mouseX && mouseX <= rightHowtoButton &&
      topHowtoButton <= mouseY && mouseY <= bottomHowtoButton) {
      howtoButton.setFill(150);
      shape(howtoButton);
      if (mousePressed) {
        screen = "howto";
      }
    }

    // Event: pressing Start button
    float leftStartButton = width/2 - buttonWidth*1.2*.5;
    float rightStartButton = width/2 + buttonWidth*1.2*.5;
    float topStartButton = height*.85 - buttonWidth*.3*.5;
    float bottomStartButton = height*.85 + buttonWidth*.3*.5;
    if (leftStartButton <= mouseX && mouseX <= rightStartButton &&
      topStartButton <= mouseY && mouseY <= bottomStartButton) {
      startButton.setFill(150);
      shape(startButton);
      if (mousePressed) {
        screen = "game";
      }
    }

    // Text on How To button
    pushStyle();
    textSize(height*.05);
    fill(255);
    textAlign(CENTER, CENTER);
    text(howto, width/2, height*.75);
    popStyle();

    // Text on Start button
    pushStyle();
    textSize(height*.05);
    fill(255);
    textAlign(CENTER, CENTER);
    text(start, width/2, height*.85);
    popStyle();
  }
  
  void displayHowto() {
    // Left column
    String instruction0 = "\tThere are a number of mines to find.\n\nPress SPACE to reveal a cell you think is safe.\n\nPress F to flag a cell you think is a mine.\n\nRevealing a safe cell earns you 2 points and\nshows the number of mines in neighbor cells\n(visible when you are at that cell).";
    
    pushStyle();
    textSize(height*.03);
    textFont(quicksand);
    textAlign(LEFT, CENTER);
    fill(0);
    text(instruction0, width*.02, height*.5);
    popStyle();
    
    // Right column
    PImage howto0 = loadImage("howto0.png");
    String cap0 = "move around";
    PImage howto1 = loadImage("howto1.png");
    String cap1 = "flag a cell with mine";
    PImage howto2 = loadImage("howto2.png");
    String cap2 = "reveal a safe cell";
    
    pushStyle();
    imageMode(CENTER);
    textAlign(CENTER);
    textSize(height*.03);
    textFont(quicksand);
    fill(0);
    image(howto0, width*.85, height*.2, 200, 200);
    text(cap0, width*.85, height*.2 + 120);
    image(howto1, width*.85, height*.5, 200, 200);
    text(cap1, width*.85, height*.5 + 120);
    image(howto2, width*.85, height*.8, 200, 200);
    text(cap2, width*.85, height*.8 + 120);
    popStyle();
  }

  void displayWin() {
    fill(255, 255, 255, 100);
    rect(0, 0, width, height);
    fill(0);
    textSize(height*.1);
    textAlign(CENTER, CENTER);
    text("VICTORY!", width/2, height/2);

    // New game button
    pushStyle();
    rectMode(CENTER);
    PShape newgameButton = createShape(RECT, width/2, height*.75, buttonWidth*1.2, buttonWidth*.3);
    newgameButton.setFill(0);
    shape(newgameButton);
    popStyle();

    // Event: pressing New game button
    float leftNewgameButton = width/2 - buttonWidth*1.2*.5;
    float rightNewgameButton = width/2 + buttonWidth*1.2*.5;
    float topNewgameButton = height*.75 - buttonWidth*.3*.5;
    float bottomNewgameButton = height*.75 + buttonWidth*.3*.5;
    if (leftNewgameButton <= mouseX && mouseX <= rightNewgameButton &&
      topNewgameButton <= mouseY && mouseY <= bottomNewgameButton) {
      newgameButton.setFill(150);
      shape(newgameButton);
      //if (mousePressed) {
      //  screen = "game";
      //}
    }

    // Text on New game button
    pushStyle();
    textSize(height*.05);
    fill(255);
    textAlign(CENTER, CENTER);
    text("NEW GAME", width/2, height*.75);
    popStyle();
  }

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

  void testMinehunter() {
    //println(stringToX("00"), stringToY("00"));
    //println(numNeighborMines(4, 4));
    //println("Mines: "+str(mines.size()));
    //println("Mines found: "+str(minesFound.size()));
  }
}
