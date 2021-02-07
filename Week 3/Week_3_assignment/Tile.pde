import java.util.Map;
// https://processing.org/reference/HashMap.html

class Tile {
  int value;
  color tileColor, textColor;
  float alpha = 0;
  boolean doneDisappearing = false;
  boolean overlap = false;
  boolean visible = true;
  boolean moving = false;
  boolean doneMoving = false;
  int rowPos, colPos;
  float yPos, xPos;
  HashMap<Integer, Integer> tileColorMap = new HashMap<Integer, Integer>();
  int tileSize = 100;
  int tileRound = 7;
  int gapSize = 12;
  float xOffset = width/2 - (gapSize*2.5 + tileSize*2);
  // yOffset might + extra offset to account for the score part
  float yOffset = height/2 - (gapSize*2.5 + tileSize*2);
  int gridNum = 4;
  int tileID;

  /**
   * Map tile values with corresponding colors in pairs of <Value, Color>
   * Note: wrapper class of color primitive type is Integer
   */
  void mapColors() {
    tileColorMap.put(2, color(238, 228, 218, alpha));
    tileColorMap.put(4, color(237, 224, 200, alpha));
    tileColorMap.put(8, color(242, 177, 121, alpha));
    tileColorMap.put(16, color(245, 149, 99, alpha));
    tileColorMap.put(32, color(246, 124, 96, alpha));
    tileColorMap.put(64, color(246, 94, 59, alpha));
    tileColorMap.put(128, color(237, 207, 115, alpha));
    tileColorMap.put(256, color(237, 204, 98, alpha));
    tileColorMap.put(512, color(237, 200, 80, alpha));
    tileColorMap.put(1024, color(237, 197, 63, alpha));
    tileColorMap.put(2048, color(237, 194, 45, alpha));
  }

  /**
   * Constructor of a tile
   * @param val value of the tile, must be of a value 2^n with 1 <= n <= 11
   *        row, col coordinate of the tile
   * [0, 0] is top left, [3, 3] is bottom right
   */
  Tile(int val, int row, int col) {
    value = val;
    rowPos = row;
    colPos = col;
    xPos = xPos(col);
    yPos = yPos(row);
    tileID = gridNum*row+col;
  }

  /**
   * Display a particular tile. Necessary params are all class attributes
   */
  void displayTile() {
    // Alpha might get updated so need to map colors again
    mapColors();
    tileColor = tileColorMap.get(value);
    // There are only two colors for text so no need for HashMap
    if (value <= 4) {
      textColor = color(119, 110, 101, alpha);
    } else {
      textColor = color(249, 246, 242, alpha);
    }

    updateAlpha();

    pushStyle();
    rectMode(CENTER);
    noStroke();
    fill(tileColor);
    rect(xPos, yPos, tileSize, tileSize, tileRound);
    fill(textColor);
    textSize(tileSize*.4);
    // tileSize*.5 is too big -- 4-digit values do not fit
    textAlign(CENTER, CENTER);
    text(value, xPos, yPos-textAscent()*.1);
    popStyle();
  }

  /**
   * Move tile horizontally to a new position
   * @param destCol column-coordinate of destination
   */
  void moveTileH(int destCol) {
    float oldX = xPos(colPos);
    float newX = xPos(destCol);
    float stepSize = (newX-oldX)/15;
    if (xPos != newX) {
      xPos += stepSize;
    }
    // stepSize can have long decimal part
    // Without rounding, xPos can offshoot newX by a fraction
    if (round(xPos) == newX) {
      xPos = newX;
      colPos = destCol;
      moving = false;
      doneMoving = true;
      updateID();
    }
  }

  /**
   * Move tile vertically to a new position
   * @param destRow row-coordinate of destination
   */
  void moveTileV(int destRow) {
    float oldY = yPos(rowPos);
    float newY = yPos(destRow);
    float stepSize = (newY-oldY)/15;
    if (yPos != newY) {
      yPos += stepSize;
    }
    if (round(yPos) == newY) {
      yPos = newY;
      rowPos = destRow;
      moving = false;
      doneMoving = true;
      updateID();
    }
  }

  /**
   * Change transparency of a tile. Used to make tile (dis)appear
   */
  void updateAlpha() {
    if (visible) {
      if (alpha < 255) {
        alpha += 17; // 17=255/15 (15, 30, 60 ...)
      } else {
        alpha = 255;
      }
      alpha = 255;
    } else {
      if (alpha > 0) {
        alpha -= 17;
      } else {
        alpha = 0;
      }
    }
  }

  /**
   * Update visibility of a tile to trigger its disappearing
   */
  void disappear() {
    visible = false;
  }

  /**
   * Update ID of a recently moved tile
   * So far not used much because it's too simple a calculation
   * I forget I made a function
   */
  void updateID() {
    tileID = gridNum*rowPos+colPos;
  }

  /**
   * Return the x-coordinate of a tile in pixels
   * @param colPos column coordinate (0, 1, 2, 3)
   * @return xPos corresponding x-coordinate in pixels
   */
  float xPos(int colPos) {
    return (colPos+.5)*tileSize + (colPos+1)*gapSize + xOffset;
  }

  /**
   * Return the y-coordinate of a tile in pixels
   * @param rowPos row coordinate (0, 1, 2, 3)
   * @return yPos corresponding y-coordinate in pixels
   */
  float yPos(int rowPos) {
    return (rowPos+.5)*tileSize + (rowPos+1)*gapSize + yOffset;
  }

  /**
   * Check if this tile and another tile has the same value
   * @param tile a second tile to compare
   * @return true if same value
   */
  boolean sameValue(Tile tile) {
    if (value == tile.value) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * Checks if this tile is at the top edge aka first row
   * @return true if it is at the top edge
   */
  boolean isAtTopEdge() {
    if (rowPos == 0) { 
      return true;
    } else {
      return false;
    }
  }

  /**
   * Checks if this tile is at the bottom edge aka last row
   * @return true if it is at the bottom edge
   */
  boolean isAtBottomEdge() {
    if (rowPos == 3) { 
      return true;
    } else {
      return false;
    }
  }

  /**
   * Checks if this tile is at the left edge aka first column
   * @return true if it is at the left edge
   */
  boolean isAtLeftEdge() {
    if (colPos == 0) { 
      return true;
    } else {
      return false;
    }
  }

  /**
   * Checks if this tile is at the right edge aka last column
   * @return true if it is at the right edge
   */
  boolean isAtRightEdge() {
    if (colPos == 3) { 
      return true;
    } else {
      return false;
    }
  }

  /**
   * Reset movement attributes of the tile
   * aka not moving & hasn't started moving
   */
  void resetMovement() {
    moving = false;
    doneMoving = false;
  }

  /**
   * Misc code for testing purposes
   */
  void test() {
    println("Row: "+str(rowPos));
    println("Col: "+str(colPos));
  }
}
