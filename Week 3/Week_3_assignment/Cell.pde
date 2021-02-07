import java.util.ArrayDeque;

class Cell {
  int gridNum = 4;
  int cellID;
  int rowPos, colPos;
  float yPos, xPos;
  color cellColor = color(205, 191, 180, 255);
  boolean occupied = false;
  int cellSize = 100;
  int cellRound = 7;
  int gapSize = 12;
  float xOffset;
  float yOffset;
  int count = 0;
  ArrayDeque<Tile> queue = new ArrayDeque();

  Cell(int row, int col, float offset_x, float offset_y) {
    rowPos = row;
    colPos = col;
    xOffset = offset_x;
    yOffset = offset_y;
    xPos = xPos(col);
    yPos = yPos(row);
    cellID = gridNum*row+col;
  }

  void displayCell() {
    pushStyle();
    rectMode(CENTER);
    noStroke();
    fill(cellColor);
    rect(xPos, yPos, cellSize, cellSize, cellRound);
    popStyle();
  }

  void changeStatus() {
    occupied = !occupied;
  }

  float xPos(int colPos) {
    return (colPos+.5)*cellSize + (colPos+1)*gapSize + xOffset;
  }

  float yPos(int rowPos) {
    return (rowPos+.5)*cellSize + (rowPos+1)*gapSize + yOffset;
  }
}
