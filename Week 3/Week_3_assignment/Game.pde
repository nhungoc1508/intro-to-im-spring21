import java.util.Map; //<>//
import java.util.ArrayDeque;

class Game {
  Grid grid = new Grid();
  int gridNum = 4;
  HashMap<Integer, Boolean> keyHandler = new HashMap<Integer, Boolean>();
  int numTiles = 16;
  ArrayDeque<Tile> queue0 = new ArrayDeque();
  ArrayDeque<Tile> queue1 = new ArrayDeque();
  ArrayDeque<Tile> queue2 = new ArrayDeque();
  ArrayDeque<Tile> queue3 = new ArrayDeque();

  /**
   * Constructor of a game
   * Reset keyHandler = no arrow key has been pressed
   * Randomize a tile
   */
  Game() {
    keyHandler.put(LEFT, false);
    keyHandler.put(RIGHT, false);
    keyHandler.put(UP, false);
    keyHandler.put(DOWN, false);

    randTile();
  }

  /**
   * The main proceedings of the game
   */
  void displayGame() {
    grid.displayGrid();
    displayTiles();

    // For each loop check if an arrow is pressed
    // & revoke the corresponding game movement
    if (keyHandler.get(RIGHT)) {
      moveGameRight();
    } else if (keyHandler.get(LEFT)) {
      moveGameLeft();
    } else if (keyHandler.get(UP)) {
      moveGameUp();
    } else if (keyHandler.get(DOWN)) {
      moveGameDown();
    }
    if (allDoneMoving()) {
      // This works but in the case of 2 - 2 - 2 for example it's wrong 
      checkAndMerge();

      randTile();
    }
  }

  /**
   * Check the entire game board to detect a collision
   * then merge the tiles that collided
   * A bit exhaustive to check every cell but not too taxing overall
   */
  void checkAndMerge() {
    for (int i=0; i<numTiles; i++) {
      if (grid.queueSize(i) == 2) {
        mergeTiles(i);
      }
    }
  }

  /**
   * Merge collided tiles
   * Still has a lot of bugs e.g. 3 same tiles on a row/col
   * @param id ID of the cell where the collision is
   */
  void mergeTiles(int id) {
    int value = grid.peek(id).value*2;
    int row = grid.peek(id).rowPos;
    int col = grid.peek(id).colPos;
    grid.dequeue(id);
    grid.dequeue(id);
    specificTile(value, row, col);
  }

  /**
   * Display all the valid tiles
   * Valid tiles: visible, no colliding yet
   */
  void displayTiles() {
    // For testing (console printing)
    int validTiles = 0;
    for (int i=0; i<numTiles; i++) {
      if (grid.checkIfOccupied(i)) {
        Tile curTile = grid.peek(i);
        validTiles += 1;
        curTile.displayTile();
      }
    }
  }

  /**
   * Add tiles to the four queues for moving to the right
   * @param queue the queue to be added to
   *        row the row to consider (0, 1, 2, 3)
   */
  void enqueueTilesFromRight(ArrayDeque<Tile> queue, int row) {
    queue.clear();
    // Rightmost tiles to be added (and later retrieved) first
    // e.g. [_][2][4][_]
    //      -0--1--2--3-
    //      Tile at -2- needs to move to -3- first
    //      so -2- is made vacant, -3- is made occupied
    //      When -1- moves -2- is now free
    for (int i=3; i>=0; i--) {
      int id = grid.getID(row, i);
      if (grid.checkIfOccupied(id)) {
        Tile curTile = grid.peek(id);
        queue.add(curTile);
      }
    }
  }

  /**
   * Add tiles to the four queues for moving to the left
   * @param queue the queue to be added to
   *        row the row to consider (0, 1, 2, 3)
   */
  void enqueueTilesFromLeft(ArrayDeque<Tile> queue, int row) {
    queue.clear();
    // Leftmost tiles to be added (and later retrieved) first
    // see enqueueTilesFromRight() for example, same logic
    for (int i=0; i<4; i++) {
      int id = grid.getID(row, i);
      if (grid.checkIfOccupied(id)) {
        Tile curTile = grid.peek(id);
        queue.add(curTile);
      }
    }
  }

  /**
   * Add tiles to the four queues for moving up
   * @param queue the queue to be added to
   *        col the col to consider (0, 1, 2, 3)
   */
  void enqueueTilesFromTop(ArrayDeque<Tile> queue, int col) {
    queue.clear();
    // Top tiles to be added (and later retrieved) first
    // see enqueueTilesFromRight() for example, same logic
    for (int i=0; i<4; i++) {
      int id = grid.getID(i, col);
      if (grid.checkIfOccupied(id)) {
        Tile curTile = grid.peek(id);
        queue.add(curTile);
      }
    }
  }

  /**
   * Add tiles to the four queues for moving down
   * @param queue the queue to be added to
   *        col the col to consider (0, 1, 2, 3)
   */
  void enqueueTilesFromBottom(ArrayDeque<Tile> queue, int col) {
    queue.clear();
    // Bottom tiles to be added (and later retrieved) first
    // see enqueueTilesFromRight() for example, same logic
    for (int i=3; i>=0; i--) {
      int id = grid.getID(i, col);
      if (grid.checkIfOccupied(id)) {
        Tile curTile = grid.peek(id);
        queue.add(curTile);
      }
    }
  }

  /**
   * Retrieve tiles from queues to move
   * @param queue the queue to be retrieved tiles from
   *        dir current moving direction
   */
  void moveTilesFromQueue(ArrayDeque<Tile> queue, String dir) {
    // Movement of a tile is triggered when 
    // the previous tile has finished moving
    // but the first tile in queue has no such
    // anchor point to compare to, so it needs
    // to be retrieved and moved on its own.
    if (!queue.isEmpty()) {
      boolean lastTileDone = false;
      int sizeQueue = queue.size();
      Tile curTile = queue.remove();
      if (dir == "RIGHT") {
        moveTileRight(curTile);
      } else if (dir == "LEFT") {
        moveTileLeft(curTile);
      } else if (dir == "UP") {
        moveTileUp(curTile);
      } else if (dir == "DOWN") {
        moveTileDown(curTile);
      }
      if (curTile.doneMoving) {
        lastTileDone = true;
      }
      // Then for each remaining tiles,
      // retrieve and move them
      for (int i=0; i<sizeQueue-1; i++) {
        if (lastTileDone == true) {
          curTile = queue.remove();
          if (dir == "RIGHT") {
            moveTileRight(curTile);
          } else if (dir == "LEFT") {
            moveTileLeft(curTile);
          } else if (dir == "UP") {
            moveTileUp(curTile);
          } else if (dir == "DOWN") {
            moveTileDown(curTile);
          }
          if (!curTile.doneMoving) {
            lastTileDone = false;
          }
        }
      }
    }
  }

  /**
   * Move all tiles on board to the right
   * After all have finished moving
   * lock all keyHandler values, i.e.
   * no direction is currently chosen
   */
  void moveGameRight() {
    enqueueTilesFromRight(queue0, 0);
    enqueueTilesFromRight(queue1, 1);
    enqueueTilesFromRight(queue2, 2);
    enqueueTilesFromRight(queue3, 3);
    moveTilesFromQueue(queue0, "RIGHT");
    moveTilesFromQueue(queue1, "RIGHT");
    moveTilesFromQueue(queue2, "RIGHT");
    moveTilesFromQueue(queue3, "RIGHT");
    lockMovement();
  }

  /**
   * Move all tiles on board to the left
   */
  void moveGameLeft() {
    enqueueTilesFromLeft(queue0, 0);
    enqueueTilesFromLeft(queue1, 1);
    enqueueTilesFromLeft(queue2, 2);
    enqueueTilesFromLeft(queue3, 3);
    moveTilesFromQueue(queue0, "LEFT");
    moveTilesFromQueue(queue1, "LEFT");
    moveTilesFromQueue(queue2, "LEFT");
    moveTilesFromQueue(queue3, "LEFT");
    lockMovement();
  }

  /**
   * Move all tiles on board up
   */
  void moveGameUp() {
    enqueueTilesFromTop(queue0, 0);
    enqueueTilesFromTop(queue1, 1);
    enqueueTilesFromTop(queue2, 2);
    enqueueTilesFromTop(queue3, 3);
    moveTilesFromQueue(queue0, "UP");
    moveTilesFromQueue(queue1, "UP");
    moveTilesFromQueue(queue2, "UP");
    moveTilesFromQueue(queue3, "UP");
    lockMovement();
  }

  /**
   * Move all tiles on board down
   */
  void moveGameDown() {
    enqueueTilesFromBottom(queue0, 0);
    enqueueTilesFromBottom(queue1, 1);
    enqueueTilesFromBottom(queue2, 2);
    enqueueTilesFromBottom(queue3, 3);
    moveTilesFromQueue(queue0, "DOWN");
    moveTilesFromQueue(queue1, "DOWN");
    moveTilesFromQueue(queue2, "DOWN");
    moveTilesFromQueue(queue3, "DOWN");
    lockMovement();
  }

  /**
   * Check if all the tiles have done moving
   * @return false if any tile is not done
   */
  boolean allDoneMoving() {
    for (int i=0; i<numTiles; i++) {
      if (grid.checkIfOccupied(i)) {
        Tile curTile = grid.peek(i);
        if (!curTile.doneMoving) {
          return false;
        }
      }
    }
    return true;
  }

  /**
   * Set all keyHandler values to false
   * aka no (new) direction has been chosen.
   */
  void lockMovement() {
    if (allDoneMoving()) {
      keyHandler.put(RIGHT, false);
      keyHandler.put(LEFT, false);
      keyHandler.put(UP, false);
      keyHandler.put(DOWN, false);
    }
  }

  /**
   * Randomize a new tile of value 2
   */
  void randTile() {
    // Randomize a new coordinate
    // until an empty cell is found.
    int randRow = floor(random(4));
    int randCol = floor(random(4));
    while (grid.checkIfOccupied(randRow, randCol)) {
      randRow = floor(random(4));
      randCol = floor(random(4));
    }
    Tile tile = new Tile(2, randRow, randCol);
    grid.occupy(tile);
    grid.addCount(tile);
    grid.enqueue(tile);
  }

  /**
   * Add a new tile with specified value and coordinate
   * @param val value to be set to tile
   *        row, col coordinate of tile
   */
  void specificTile(int val, int row, int col) {
    Tile tile = new Tile(val, row, col);
    grid.occupy(tile);
    grid.addCount(tile);
    grid.enqueue(tile);
  }

  /**
   * Move a tile to the rightmost valid destination
   * @param tile tile to be moved
   */
  void moveTileRight(Tile tile) {
    tile.resetMovement();
    grid.vacant(tile);
    grid.minusCount(tile);
    grid.dequeue(tile);
    tile.moving = true;
    int dest = tile.colPos;
    if (tile.moving && !tile.doneMoving) {
      dest = getRightDest(tile);
    }
    tile.moveTileH(dest);
    grid.occupy(tile);
    grid.addCount(tile);
    grid.enqueue(tile);
  }

  /**
   * Move a tile to the leftmost valid destination
   * @param tile tile to be moved
   */
  void moveTileLeft(Tile tile) {
    tile.resetMovement();
    grid.vacant(tile);
    grid.minusCount(tile);
    grid.dequeue(tile);
    tile.moving = true;
    int dest = tile.colPos;
    if (tile.moving && !tile.doneMoving) {
      dest = getLeftDest(tile);
    }
    tile.moveTileH(dest);
    grid.occupy(tile);
    grid.addCount(tile);
    grid.enqueue(tile);
  }

  /**
   * Move a tile to the top valid destination
   * @param tile tile to be moved
   */
  void moveTileUp(Tile tile) {
    tile.resetMovement();
    grid.vacant(tile);
    grid.minusCount(tile);
    grid.dequeue(tile);
    tile.moving = true;
    int dest = tile.rowPos;
    if (tile.moving && !tile.doneMoving) {
      dest = getTopDest(tile);
    }
    tile.moveTileV(dest);
    grid.occupy(tile);
    grid.addCount(tile);
    grid.enqueue(tile);
  }

  /**
   * Move a tile to the bottom valid destination
   * @param tile tile to be moved
   */
  void moveTileDown(Tile tile) {
    tile.resetMovement();
    grid.vacant(tile);
    grid.minusCount(tile);
    grid.dequeue(tile);
    tile.moving = true;
    int dest = tile.rowPos;
    if (tile.moving && !tile.doneMoving) {
      dest = getBottomDest(tile);
    }
    tile.moveTileV(dest);
    grid.occupy(tile);
    grid.addCount(tile);
    grid.enqueue(tile);
  }

  /**
   * Return coordinate of the rightmost valid destination for a tile
   * @param tile tile to consider
   * @return col column coordinate of destination cell
   */
  int getRightDest(Tile tile) {
    if (tile.isAtRightEdge()) {
      // If current cell is already at right edge, don't move it
      // aka destination = itself
      //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is at right edge.");
      return tile.colPos;
    } else {
      // If it is not at edge, consider the tile to the right
      //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is NOT at right edge.");
      int curCol = tile.colPos + 1;
      while (curCol <= 3) {
        // Keep checking further (within board) until an invalid destination
        //println("Checking tile at ["+str(tile.rowPos)+", "+str(curCol)+"]");
        if (grid.checkIfOccupied(tile.rowPos, curCol)) {
          // If the current cell has another tile, check if two tiles have the same value
          // If they do they can be in the same cell (collision & merging happens)
          // If they don't then move back to the last valid destination
          //println("Tile at ["+str(tile.rowPos)+", "+str(curCol)+"] is occupied.");
          int rightTileID = gridNum*tile.rowPos + curCol;
          //Tile rightTile = tiles[rightTileID];
          Tile rightTile = grid.peek(rightTileID);
          if (tile.sameValue(rightTile)) {
            //println("Tile at ["+str(rightTile.rowPos)+", "+str(rightTile.colPos)+"] has the same value.");
            tile.overlap = true;
            return curCol; // ADDED -1 FOR TESTING
          } else {
            //println("Tile at ["+str(rightTile.rowPos)+", "+str(rightTile.colPos)+"] has different value.");
            return curCol-1;
          }
        } else {
          // If the current cell is free, check further
          //println("Tile at ["+str(tile.rowPos)+", "+str(curCol)+"] is NOT occupied.");
          curCol += 1;
        }
      }
      return curCol-1;
    }
  }

  int getLeftDest(Tile tile) {
    // See getRightDest(), same logic
    if (tile.isAtLeftEdge()) {
      //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is at left edge.");
      return tile.colPos;
    } else {
      //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is NOT at left edge.");
      int curCol = tile.colPos - 1;
      while (curCol >= 0) {
        //println("Checking tile at ["+str(tile.rowPos)+", "+str(curCol)+"]");
        if (grid.checkIfOccupied(tile.rowPos, curCol)) {
          //println("Tile at ["+str(tile.rowPos)+", "+str(curCol)+"] is occupied.");
          int leftTileID = gridNum*tile.rowPos + curCol;
          //Tile leftTile = tiles[leftTileID];
          Tile leftTile = grid.peek(leftTileID);
          if (tile.sameValue(leftTile)) {
            //println("Tile at ["+str(leftTile.rowPos)+", "+str(leftTile.colPos)+"] has the same value.");
            return curCol; // ADDED +1 FOR TESTING
          } else {
            //println("Tile at ["+str(leftTile.rowPos)+", "+str(leftTile.colPos)+"] has different value.");
            return curCol+1;
          }
        } else {
          //println("Tile at ["+str(tile.rowPos)+", "+str(curCol)+"] is NOT occupied.");
          curCol -= 1;
        }
      }
      return curCol+1;
    }
  }

  int getTopDest(Tile tile) {
    // See getRightDest(), same logic
    if (tile.isAtTopEdge()) {
      //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is at top edge.");
      return tile.rowPos;
    } else {
      //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is NOT at top edge.");
      int curRow = tile.rowPos - 1;
      while (curRow >= 0) {
        //println("Checking tile at ["+str(tile.rowPos)+", "+str(curCol)+"]");
        if (grid.checkIfOccupied(curRow, tile.colPos)) {
          //println("Tile at ["+str(curRow)+", "+str(tile.colPos)+"] is occupied.");
          int topTileID = gridNum*curRow + tile.colPos;
          //Tile topTile = tiles[topTileID];
          Tile topTile = grid.peek(topTileID);
          if (tile.sameValue(topTile)) {
            //println("Tile at ["+str(topTile.rowPos)+", "+str(topTile.colPos)+"] has the same value.");
            return curRow; // ADDED +1 FOR TESTING
          } else {
            //println("Tile at ["+str(topTile.rowPos)+", "+str(topTile.colPos)+"] has different value.");
            return curRow+1;
          }
        } else {
          //println("Tile at ["+str(curRow)+", "+str(tile.colPos)+"] is NOT occupied.");
          curRow -= 1;
        }
      }
      return curRow+1;
    }
  }

  int getBottomDest(Tile tile) {
    // See getRightDest(), same logic
    //println("Moving tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"]");
    if (tile.isAtBottomEdge()) {
      //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is at bottom edge.");
      //println("return"+str(tile.rowPos));
      return tile.rowPos;
    } else {
      //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is NOT at bottom edge.");
      int curRow = tile.rowPos + 1;
      while (curRow <= 3) {
        //println("Checking tile at ["+str(curRow)+", "+str(tile.colPos)+"]");
        if (grid.checkIfOccupied(curRow, tile.colPos)) {
          //println("Tile at ["+str(curRow)+", "+str(tile.colPos)+"] is occupied.");
          int bottomTileID = gridNum*curRow + tile.colPos;
          //Tile bottomTile = tiles[bottomTileID];
          Tile bottomTile = grid.peek(bottomTileID);
          if (tile.sameValue(bottomTile)) {
            //println("Tile at ["+str(bottomTile.rowPos)+", "+str(bottomTile.colPos)+"] has the same value.");
            //println("return"+str(curRow));
            return curRow; // ADDED -1 FOR TESTING
          } else {
            //println("Tile at ["+str(bottomTile.rowPos)+", "+str(bottomTile.colPos)+"] has different value.");
            //println("return"+str(curRow-1));
            return curRow-1;
          }
        } else {
          //println("Tile at ["+str(curRow)+", "+str(tile.colPos)+"] is NOT occupied.");
          curRow += 1;
        }
      }
      //println("return"+str(curRow-1));
      return curRow-1;
    }
  }
}
