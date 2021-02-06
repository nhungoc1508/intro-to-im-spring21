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

  Grid() {
    for (int i=0; i<gridNum; i++) {
      for (int j=0; j<gridNum; j++) {
        Cell cell = new Cell(i, j, xOffset, yOffset);
        cells.add(cell);
      }
    }
  }

  void setGridSize(int size) {
    gridSize = size;
  }

  void displayGrid() {
    displayBg();
    for (int i=0; i<cells.size(); i++) {
      Cell cell = cells.get(i);
      cell.displayCell();
    }
  }

  void displayBg() {
    color bgColor = color(187, 172, 160, 255);
    pushStyle();
    fill(bgColor);
    noStroke();
    rectMode(CENTER);
    rect(width/2, height/2, gridSize, gridSize, gridRound);
    popStyle();
  }

  boolean checkIfOccupied(int row, int col) {
    int id = getID(row, col);
    Cell cell = cells.get(id);
    return cell.occupied;
  }

  boolean checkIfOccupied(int id) {
    Cell cell = cells.get(id);
    return cell.occupied;
  }

  void changeStatus(Tile tile) {
    int id = getID(tile.rowPos, tile.colPos);
    Cell cell = cells.get(id);
    cell.changeStatus();
  }

  void vacant(Tile tile) {
    int id = getID(tile.rowPos, tile.colPos);
    Cell cell = cells.get(id);
    cell.occupied = false;
  }

  void occupy(Tile tile) {
    int id = getID(tile.rowPos, tile.colPos);
    Cell cell = cells.get(id);
    cell.occupied = true;
  }

  void setCurrentValue(Tile tile) {
    int id = getID(tile.rowPos, tile.colPos);
    Cell cell = cells.get(id);
    cell.currentValue = tile.value;
  }

  int getID(int row, int col) {
    return gridNum*row+col;
  }

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
