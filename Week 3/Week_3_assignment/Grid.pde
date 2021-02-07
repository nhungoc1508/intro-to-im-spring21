class Grid {
  float gridSize = 460;
  int gridNum = 4;
  int gridRound = 7;
  int cellSize = 100;
  int gapSize = 12;
  ArrayList<Cell> cells = new ArrayList<Cell>();
  float xOffset = width/2 - (gapSize*2.5 + cellSize*2);
  // yOffset might + extra offset to account for the score part
  float yOffset = height/2 - (gapSize*2.5 + cellSize*2);

  /**
   * Constructor of a grid
   */
  Grid() {
    for (int i=0; i<gridNum; i++) {
      for (int j=0; j<gridNum; j++) {
        Cell cell = new Cell(i, j, xOffset, yOffset);
        cells.add(cell);
      }
    }
  }

  /**
   * Change the size of a grid
   * To be honest I forgot I ever made this at all
   * Might find some use for it?
   */
  void setGridSize(int size) {
    gridSize = size;
  }

  /**
   * Display the background and the cells
   */
  void displayGrid() {
    displayBg();
    for (int i=0; i<cells.size(); i++) {
      Cell cell = cells.get(i);
      cell.displayCell();
    }
  }

  /**
   * Display the background
   * Once again I'm using pushStyle() popStyle() to be sure
   */
  void displayBg() {
    color bgColor = color(187, 172, 160, 255);
    pushStyle();
    fill(bgColor);
    noStroke();
    rectMode(CENTER);
    rect(width/2, height/2, gridSize, gridSize, gridRound);
    popStyle();
  }

  /**
   * Check if a cell is occupied
   * Though I don't think these params are ever used
   * @param row, col coordinate of the cell
   * @return true if occupied
   */
  boolean checkIfOccupied(int row, int col) {
    int id = getID(row, col);
    Cell cell = cells.get(id);
    return cell.occupied;
  }

  /**
   * Check if a cell is occupied
   * @param id ID of the cell
   * @return true if occupied
   */
  boolean checkIfOccupied(int id) {
    Cell cell = cells.get(id);
    return cell.occupied;
  }

  //void changeStatus(Tile tile) {
  //  int id = getID(tile.rowPos, tile.colPos);
  //  Cell cell = cells.get(id);
  //  cell.changeStatus();
  //}

  /**
   * Change an occupied cell to unoccupied
   * @param tile the tile to be moved or disappear
   */
  void vacant(Tile tile) {
    int id = getID(tile.rowPos, tile.colPos);
    Cell cell = cells.get(id);
    cell.occupied = false;
  }

  /**
   * Change an occupied cell to unoccupied
   * @param id ID of the tile to be moved away or disappear
   *           and/or cell to be cleared
   */
  void vacant(int id) {
    Cell cell = cells.get(id);
    cell.occupied = false;
  }

  /**
   * Change an unoccupied cell to occupied
   * @param tile the tile to be moved here or appear
   */
  void occupy(Tile tile) {
    int id = getID(tile.rowPos, tile.colPos);
    Cell cell = cells.get(id);
    cell.occupied = true;
  }

  /**
   * Change an unoccupied cell to occupied
   * @param id ID of the tile to be moved here or appear
   *           and/or cell to be occupied
   */
  void occupy(int id) {
    Cell cell = cells.get(id);
    cell.occupied = true;
  }

  /**
   * Add to the count of the cell (how many tiles are in it)
   * Cell's count attribute is actually kinda redundant.
   * Only needs to check the size of the queue.
   * @param tile the tile at the coordinate to be checked
   */
  void addCount(Tile tile) {
    int id = getID(tile.rowPos, tile.colPos);
    Cell cell = cells.get(id);
    cell.count += 1;
  }

  /**
   * Minus from the count of the cell
   * @param tile the tile at the coordinate to be checked
   */
  void minusCount(Tile tile) {
    int id = getID(tile.rowPos, tile.colPos);
    Cell cell = cells.get(id);
    cell.count -= 1;
  }

  /**
   * Add a tile to (the end of) a cell's queue
   * @param tile tile to be added
   */
  void enqueue(Tile tile) {
    int id = getID(tile.rowPos, tile.colPos);
    Cell cell = cells.get(id);
    cell.queue.add(tile);
  }

  /**
   * Retrieve and remove a tile from (the head of) a cell's queue
   * @param tile tile at the cell in question
   * @return tile at the head of the cell's queue
   */
  Tile dequeue(Tile tile) {
    int id = getID(tile.rowPos, tile.colPos);
    Cell cell = cells.get(id);
    return cell.queue.remove();
  }

  /**
   * Retrieve and remove a tile from (the head of) a cell's queue
   * @param id coordinate of the cell in question
   * @return tile at the head of the cell's queue
   */
  Tile dequeue(int id) {
    Cell cell = cells.get(id);
    return cell.queue.remove();
  }

  /**
   * Retrieve without removing a tile from the head of a cell's queue
   * @param id coordinate of the cell in question
   * @return tile at the head of the cell's queue
   */
  Tile peekFirst(int id) {
    Cell cell = cells.get(id);
    return cell.queue.peekFirst();
  }

  /**
   * Retrieve without removing a tile from the end of a cell's queue
   * @param id coordinate of the cell in question
   * @return tile at the end of the cell's queue
   */
  Tile peekLast(int id) {
    Cell cell = cells.get(id);
    return cell.queue.peekLast();
  }

  /**
   * Retrieve without removing a tile from the head of a cell's queue
   * I've just realized it's equivalent to peekFirst()
   * @param id coordinate of the cell in question
   * @return tile at the head of the cell's queue
   */
  Tile peek(int id) {
    Cell cell = cells.get(id);
    return cell.queue.peek();
  }

  /**
   * Return the current size of a cell's queue
   * aka how many tiles it currently contains
   * @param id coordinate of the cell to check
   * @return size of cell's queue
   */
  int queueSize(int id) {
    Cell cell = cells.get(id);
    return cell.queue.size();
  }

  /**
   * Check if a collision is happenning at a cell
   * Can be modified to get rid of count attribute
   * @param tile tile at the cell to check
   * @return true if a cell currently contains >1 tiles
   */
  boolean checkCollision(Tile tile) {
    int id = getID(tile.rowPos, tile.colPos);
    Cell cell = cells.get(id);
    if (cell.count == 2) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * Check if a collision is happenning at any cell
   * @return true if any cell currently contains >1 tiles
   */
  boolean checkCollision() {
    for (int i=0; i<cells.size(); i++) {
      Cell cell = cells.get(i);
      if (cell.queue.size() == 2) {
        return true;
      }
    }
    return false;
  }

  /**
   * Return the coordinate of the cell with a collision
   * Only gets revoked when there is a collision anywhere in the board
   * @return i id of the first cell with a collision
   */
  int whereCollision() {
    for (int i=0; i<cells.size(); i++) {
      Cell cell = cells.get(i);
      if (cell.queue.size() == 2) {
        println("Collision in: "+str(i));
        return i;
      }
    }
    return -1;
  }
  /**
   * Return tile/cell ID corresponding to a coordinate
   * Rarely used, calling it is just as long as writing the code
   * @param row, col coordinate
   */
  int getID(int row, int col) {
    return gridNum*row+col;
  }
  
  /**
   * Misc code for testing purposes
   */
  void occHelper() {
    for (int i=0; i<4; i++) {
      for (int j=0; j<4; j++) {
        if (checkIfOccupied(i, j)) {
          println(i, j);
        }
      }
    }
  }
}
