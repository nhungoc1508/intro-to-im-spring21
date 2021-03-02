class Minehunter {
  int numRow = 8;
  int numCol = 8;
  int numMines = 8;
  boolean board[][] = new boolean[numRow][numCol];
  ArrayList<PVector> mines = new ArrayList<PVector>();
  ArrayList<PVector> minesFound = new ArrayList<PVector>();
  ArrayList<PVector> flags = new ArrayList<PVector>();
  ArrayList<PVector> revealed = new ArrayList<PVector>();
  ArrayList<PVector> hints = new ArrayList<PVector>();
  ArrayList<PVector> safeCells = new ArrayList<PVector>();

  float buttonWidth;

  PImage flagImg = loadImage("images/flag.png");
  PImage mineImg = loadImage("images/mine.png");
  PImage bg = loadImage("images/tile0.png");

  Player player0, player;
  Reward reward;

  /**
   * Constructor of a game
   */
  Minehunter() {
    player0 = new Player(); // animated avatar for welcome screen
    player = new Player();
    reward = new Reward();

    textSize(height*.05);
    buttonWidth = textWidth("NEW GAME");

    // Initializing gameboard with no mine
    for (int i=0; i<numRow; i++) {
      for (int j=0; j<numCol; j++) {
        board[i][j] = false;
        PVector coordinates = new PVector(i, j);
        safeCells.add(coordinates);
      }
    }

    while (mines.size() != numMines) {
      int i = int(random(numRow));
      int j = int(random(numCol));
      if (board[i][j] == false) {
        board[i][j] = true;
        PVector coordinates = new PVector(i, j);
        mines.add(coordinates);
        safeCells.remove(coordinates);
      }
    }
  }


  /**
   * Initialization of a Minehunter object
   * Like constructor sans small details
   * Used for resetting game
   */
  void manualInit() {
    player = new Player();
    reward = new Reward();

    textSize(height*.05);
    buttonWidth = textWidth("NEW GAME");

    // Initializing gameboard with no mine
    for (int i=0; i<numRow; i++) {
      for (int j=0; j<numCol; j++) {
        board[i][j] = false;
        PVector coordinates = new PVector(i, j);
        safeCells.add(coordinates);
      }
    }

    while (mines.size() != numMines) {
      int i = int(random(numRow));
      int j = int(random(numCol));
      if (board[i][j] == false) {
        board[i][j] = true;
        PVector coordinates = new PVector(i, j);
        mines.add(coordinates);
        safeCells.remove(coordinates);
      }
    }
  }

  /**
   * Get number of neighbor cells with mines
   * 'neighbor cells' = adjacent cells horizontally,
   * vertically, diagonally
   * @param row, col coordinates of the cell
   * @return count number of neighbor cells with mines
   */
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

  /**
   * Plant a flag to a free cell (not revealed yet by player or
   * through getting hint) or un-plant a flag from a flagged cell
   */
  void changeFlag() {
    PVector coordinates = new PVector(player.i, player.j);
    if (!revealed.contains(coordinates)) {
      if (!flags.contains(coordinates) && !hints.contains(coordinates)) {
        flags.add(coordinates);
        safeCells.remove(coordinates);
        if (isMine(player.i, player.j)) {
          if (!minesFound.contains(coordinates)) {
            minesFound.add(coordinates);
          }
        }
      } else {
        flags.remove(coordinates);
      }
      flagSound.amp(0.5);
      flagSound.play();
    }
  }

  /**
   * Display flags on all flagged cells
   */
  void displayFlags() {
    for (PVector flag : flags) {
      imageMode(CENTER);
      float x = (flag.x + 0.5) * cellSize;
      float y = (flag.y + 0.5) * cellSize;
      image(flagImg, x, y, cellSize, cellSize);
    }
  }

  /**
   * Reveal the cell where the player currently is
   * If it's a safe cell, reveal number of neighbor mines
   * (visible while player is at the specific cell)
   * If it's a mine, the mine explodes and player loses
   */
  void revealCell() {
    PVector coordinates = new PVector(player.i, player.j);
    if (!flags.contains(coordinates)) {
      if (!isMine(player.i, player.j)) {
        if (!revealed.contains(coordinates) && !hints.contains(coordinates)) {
          revealed.add(coordinates);
          safeCells.remove(coordinates);
          reward.collectReward();
          safeSound.amp(0.3);
          safeSound.play();
        }
      } else {
        mineSound.amp(0.5);
        mineSound.play();
        screen = "lose";
      }
    }
  }

  /**
   * Display the number of neighbor mines of the cell where the
   * player is if the player has revealed said cell
   */
  void displayRevealedCells() {
    for (PVector cell : revealed) {
      int i = int(cell.x);
      int j = int(cell.y);
      if ((i == player.i && j == player.j)) {
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

  /**
   * Display the number of neighbor mines of all the cells
   * obtained by getting hints. These numbers are visible
   * permanently, unlike revealed cells
   */
  void displayHints() {
    for (PVector cell : hints) {
      int i = int(cell.x);
      int j = int(cell.y);
      pushMatrix();
      translate(cellSize*.5, cellSize*.5);
      fill(0);
      textSize(cellSize*.4);
      textAlign(CENTER, CENTER);
      text(str(numNeighborMines(i, j)), i*cellSize, j*cellSize);
      popMatrix();
    }
  }

  /**
   * Display all the mines, used when the user loses
   */
  void displayMines() {
    for (PVector mine : mines) {
      imageMode(CENTER);
      float x = (mine.x + 0.5) * cellSize;
      float y = (mine.y + 0.5) * cellSize;
      image(mineImg, x, y, cellSize, cellSize);
    }
  }

  /**
   * Check if a cell has a mine
   * @param i, j row and column coordinates of the cell
   * @return true if it is a mine, false otherwise
   */
  boolean isMine(int i, int j) {
    return board[i][j];
  }

  /**
   * Check if player has won (has flagged all mines)
   * @return true if all mines have been flagged
   */
  boolean gameWon() {
    return minesFound.size() == mines.size();
  }

  /**
   * Display 8-bit texture in place of game board
   * Slows down the program extensively, currently not used
   */
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

  /**
   * Display the game board
   * Highlight the current position of the player
   * Display the numbers of neighbor cells at hinted cells
   */
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
        fill(playerColor);
        rect(player.i*cellSize, player.j*cellSize, cellSize, cellSize);
        PVector coordinates = new PVector(i, j);
        if (screen == "win" || screen == "lose" || hints.contains(coordinates)) {
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
    popMatrix();
  }

  /**
   * Display the entire game including board, player, rewards
   * @param ongoing true if game is in progress, player can move
   *                false if game has ended, player cannot move
   */
  void displayGame(boolean ongoing) {
    displayBoard();
    displayFlags();
    displayRevealedCells();
    displayHints();
    boolean throwaway = displayHintButton();
    if (!gameWon() && ongoing) {
      player.movePlayer();
    }
    player.displayPlayer();
    reward.displayReward();
    if (gameWon()) {
      screen = "win";
    }
  }

  /**
   * Display the welcome screen
   * Include: game name, animated avatar, buttons
   */
  void displayWelcome() {
    fill(255);
    rect(0, 0, width, height);
    fill(0);
    textSize(height*.1);
    textAlign(CENTER, CENTER);
    text("MINEHUNTER", width/2, height/3);

    // Animated avatar moving on its own
    player0.x = width/2;
    player0.y = height/2;
    player0.displayPlayer();
    player0.autoMove = true;
    player0.movePlayer();

    makeButton("HOW TO", "howto", 0.75);
    makeButton("START", "game", 0.85);
  }

  /**
   * Display instructions of the game
   * Include: instructions, visuals, button to start
   */
  void displayHowto() {
    // Left column
    String instruction0 = "Press SPACE to reveal a cell you think is safe.\n\nPress F to flag a cell you think is a mine.\n\nRevealing a safe cell earns you 2 points and\nshows the number of mines in neighbor cells\n(visible when you are at that cell).\n\nPress HINT to get a safe cell (-10 points).\n\nYou lose when you reveal a cell with mine.\n\nYou win when you flag all cells with mines.";

    pushStyle();
    textSize(height*.03);
    textFont(quicksand);
    textAlign(LEFT, CENTER);
    fill(0);
    text(instruction0, width*.05, height*.4);
    popStyle();

    // Right column
    PImage howto0 = loadImage("images/howto0.png");
    String cap0 = "move around";
    PImage howto1 = loadImage("images/howto1.png");
    String cap1 = "flag a cell with mine";
    PImage howto2 = loadImage("images/howto2.png");
    String cap2 = "reveal a safe cell";

    pushStyle();
    imageMode(CENTER);
    textAlign(CENTER);
    textSize(height*.03);
    textFont(quicksand);
    fill(0);
    image(howto0, width*.85, height*.2, 200, 200);
    text(cap0, width*.85, height*.2 + 140);
    image(howto1, width*.85, height*.5, 200, 200);
    text(cap1, width*.85, height*.5 + 140);
    image(howto2, width*.85, height*.8, 200, 200);
    text(cap2, width*.85, height*.8 + 140);
    popStyle();

    makeButton("START", "game", 0.85);
  }

  /**
   * Display the result of the game and points
   * @param result "win" or "lose" to display accordingly
   */
  void displayResult(String result) {
    String displayText;
    if (result == "win") {
      displayText = "YOU WON!";
    } else {
      displayText = "YOU LOST!";
    }
    pushStyle();
    fill(255, 255, 255, 100);
    rect(0, 0, width, height);
    fill(0);
    textSize(height*.1);
    textAlign(CENTER, CENTER);
    text(displayText + "\nYOUR POINTS: " + str(reward.currentReward), width/2, height/2);
    makeButton("NEW GAME", "newgame", 0.75);
  }

  /**
   * Reset game
   */
  void newGame() {
    mines.clear();
    minesFound.clear();
    flags.clear();
    revealed.clear();
    hints.clear();
    safeCells.clear();
    manualInit();
    screen = "game";
  }

  /**
   * Get a safe cell for the cost of 10 points
   * Conditions: player has >= 10 points left
   *             there is at least one unrevealed & unflagged safe cell
   */
  void getHint() {
    if (!safeCells.isEmpty() && reward.currentReward >= 10) {
      reward.loseReward();
      safeSound.amp(0.3);
      safeSound.play();
      int index = int(random(safeCells.size()));
      hints.add(safeCells.get(index));
      safeCells.remove(index);
    }
  }

  /**
   * Display the HINT button
   * Doubled as checking if the button is hovered over
   * @return true if button is hovered over, false otherwise
   */
  boolean displayHintButton() {
    float x = width - padding - 4*cellSize;
    float y = padding + cellSize*2;
    float w = cellSize*4;
    float h = cellSize;
    PShape hintButton = createShape(RECT, x, y, w, h);
    color hintButtonHover = color(237, 194, 45);  
    if (reward.currentReward < 10) {
      hintButton.setFill(hintButtonHover);
    } else {
      hintButton.setFill(helpColor);
    }
    pushStyle();
    stroke(255);
    strokeWeight(2);
    shape(hintButton);
    if (x <= mouseX && mouseX <= x+w &&
      y <= mouseY && mouseY <= y+h && screen == "game") {
      hintButton.setFill(hintButtonHover);
      shape(hintButton);
      fill(255);
      textSize(cellSize*.4);
      textAlign(CENTER, CENTER);
      String displayText = "HINT";
      text(displayText, x+w/2, y+h/2);
      return true;
    }
    fill(255);
    textSize(cellSize*.4);
    textAlign(CENTER, CENTER);
    String displayText = "HINT";
    text(displayText, x+w/2, y+h/2);
    popStyle();
    return false;
  }

  /**
   * Generic template for buttons (except HINT)
   * @param content text to display on the button
   *        func which screen to switch to
   *        h y-position of the button (center mode) by % of height
   */
  void makeButton(String content, String func, float h) {
    // Shape button
    pushStyle();
    rectMode(CENTER);
    PShape button = createShape(RECT, width/2, height*h, buttonWidth*1.2, buttonWidth*.3);
    button.setFill(0);
    shape(button);
    // Event: pressing button
    float leftButton = width/2 - buttonWidth*1.2*.5;
    float rightButton = width/2 + buttonWidth*1.2*.5;
    float topButton = height*h - buttonWidth*.3*.5;
    float bottomButton = height*h + buttonWidth*.3*.5;
    if (leftButton <= mouseX && mouseX <= rightButton &&
      topButton <= mouseY && mouseY <= bottomButton) {
      button.setFill(150);
      if (mousePressed) {
        screen = func;
        if (func == "game" || func == "newgame") {
          newgameSound.amp(0.5);
          newgameSound.play();
        }
      }
    }
    // Text on button
    textSize(height*.05);
    fill(255);
    textAlign(CENTER, CENTER);
    text(content, width/2, height*h);
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
}
