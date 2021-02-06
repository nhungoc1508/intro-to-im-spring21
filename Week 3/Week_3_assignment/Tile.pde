import java.util.Map;

class Tile {
  int value;
  color tileColor, textColor;
  float alpha = 0;
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
   * Note: wrap class of color primitive type is Integer
   * @param  None
   * @return None
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
   * @param  None
   * @return None
   */
  void displayTile() {
    // Alpha might get updated so need to map colors again
    mapColors();
    tileColor = tileColorMap.get(value);
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
   * Move tile to a new position
   * @param destRow, destCol: coordinates of destination
   * @return None
   */
  void moveTileH(int destCol) {
    float oldX = xPos(colPos);
    float newX = xPos(destCol);
    float stepSize = (newX-oldX)/15;
    if (xPos != newX) {
      xPos += stepSize;
    }
    if (round(xPos) == newX) {
      xPos = newX;
      colPos = destCol;
      moving = false;
      doneMoving = true;
      updateID();
      println("Done movingH");
    }
  }

  void moveTileV(int destRow) {
    // Get step size from distance
    float oldY = yPos(rowPos);
    float newY = yPos(destRow);
    float stepSize = (newY-oldY)/15;
    //println(yPos, rowPos);
    if (yPos != newY) {
      yPos += stepSize;
    }
    if (round(yPos) == newY) {
      yPos = newY;
      rowPos = destRow;
      moving = false;
      doneMoving = true;
      updateID();
      println("Done movingV");
    }
    //println(yPos, destRow);
  }

  void updateAlpha() {
    if (visible) {
      if (alpha < 255) {
        alpha += 17; // 17=255/15 (15, 30, 60 ...)
      } else {
        alpha = 255;
      }
    } else {
      if (alpha > 0) {
        alpha -= 17;
      } else {
        alpha = 0;
      }
    }
  }

  void disappear() {
    visible = false;
  }

  void updateID() {
    tileID = gridNum*rowPos+colPos;
  }

  float xPos(int colPos) {
    return (colPos+.5)*tileSize + (colPos+1)*gapSize + xOffset;
  }

  float yPos(int rowPos) {
    return (rowPos+.5)*tileSize + (rowPos+1)*gapSize + yOffset;
  }
  
  boolean sameValue(Tile tile) {
    if (value == tile.value) {
      return true;
    } else {
      return false;
    }
  }

  boolean isAtTopEdge() {
    if (rowPos == 0) { 
      return true;
    } else {
      return false;
    }
  }

  boolean isAtBottomEdge() {
    if (rowPos == 3) { 
      return true;
    } else {
      return false;
    }
  }

  boolean isAtLeftEdge() {
    if (colPos == 0) { 
      return true;
    } else {
      return false;
    }
  }

  boolean isAtRightEdge() {
    if (colPos == 3) { 
      return true;
    } else {
      return false;
    }
  }
  
  void resetMovement() {
    moving = false;
    doneMoving = false;
  }

  void test() {
    /** Misc code for testing purposes */
    println("Row: "+str(rowPos));
    println("Col: "+str(colPos));
  }
}
