import java.util.ArrayDeque;
// https://docs.oracle.com/javase/9/docs/api/java/util/ArrayDeque.html

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

  /**
   * Constructor of a cell
   * @param row, col coordinate of the cell
   *        offset_x, offset_y offets to align the game board
   */
  Cell(int row, int col, float offset_x, float offset_y) {
    rowPos = row;
    colPos = col;
    xOffset = offset_x;
    yOffset = offset_y;
    xPos = xPos(col);
    yPos = yPos(row);
    cellID = gridNum*row+col;
  }

  /**
   * Display the cell
   * I'm warry of unpredicted behavior hence pushStyle() popStyle()
   */
  void displayCell() {
    pushStyle();
    rectMode(CENTER);
    noStroke();
    fill(cellColor);
    rect(xPos, yPos, cellSize, cellSize, cellRound);
    popStyle();
  }

  /**
   * Return the x-coordinate of a cell in pixels
   * @param colPos column coordinate (0, 1, 2, 3)
   * @return xPos corresponding x-coordinate in pixels
   */
  float xPos(int colPos) {
    return (colPos+.5)*cellSize + (colPos+1)*gapSize + xOffset;
  }

  /**
   * Return the y-coordinate of a cell in pixels
   * @param colPos column coordinate (0, 1, 2, 3)
   * @return yPos corresponding y-coordinate in pixels
   */
  float yPos(int rowPos) {
    return (rowPos+.5)*cellSize + (rowPos+1)*gapSize + yOffset;
  }
}
