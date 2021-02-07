import java.util.Map; //<>// //<>//
import java.util.ArrayDeque;

class Game {
  Grid grid = new Grid();
  //ArrayList<Tile> tiles = new ArrayList<Tile>(16);
  Tile[] tiles = new Tile[16];
  int gridNum = 4;
  HashMap<Integer, Boolean> keyHandler = new HashMap<Integer, Boolean>();
  Tile tile, tile1;
  int numTiles = 16;
  ArrayDeque<Tile> queue0 = new ArrayDeque();
  ArrayDeque<Tile> queue1 = new ArrayDeque();
  ArrayDeque<Tile> queue2 = new ArrayDeque();
  ArrayDeque<Tile> queue3 = new ArrayDeque();

  Game() {
    keyHandler.put(LEFT, false);
    keyHandler.put(RIGHT, false);
    keyHandler.put(UP, false);
    keyHandler.put(DOWN, false);

    //specificTile(2, 0, 0);
    //specificTile(4, 0, 1);
    //specificTile(8, 1, 1);
    //specificTile(16, 2, 0);
    //specificTile(64, 3, 1);

    randTile();
  }

  void displayGame() {
    grid.displayGrid();
    displayTiles();
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

  void checkAndMerge() {
    for (int i=0; i<numTiles; i++) {
      if (grid.queueSize(i) == 2) {
        mergeTiles(i);
      }
    }
  }

  void displayTiles() {
    int validTiles = 0;
    for (int i=0; i<numTiles; i++) {
      if (grid.checkIfOccupied(i)) {
        Tile curTile = grid.peek(i);
        validTiles += 1;
        curTile.displayTile();
      }
    }
    println("Displaying: "+str(validTiles));
  }

  void enqueueTilesFromRight(ArrayDeque<Tile> queue, int row) {
    queue.clear();
    // Add tiles
    for (int i=3; i>=0; i--) {
      int id = grid.getID(row, i);
      if (grid.checkIfOccupied(id)) {
        Tile curTile = grid.peek(id);
        queue.add(curTile);
      }
    }
  }

  void enqueueTilesFromLeft(ArrayDeque<Tile> queue, int row) {
    queue.clear();
    // Add tiles
    for (int i=0; i<4; i++) {
      int id = grid.getID(row, i);
      if (grid.checkIfOccupied(id)) {
        Tile curTile = grid.peek(id);
        queue.add(curTile);
      }
    }
  }

  void enqueueTilesFromTop(ArrayDeque<Tile> queue, int col) {
    queue.clear();
    // Add tiles
    for (int i=0; i<4; i++) {
      int id = grid.getID(i, col);
      if (grid.checkIfOccupied(id)) {
        Tile curTile = grid.peek(id);
        queue.add(curTile);
      }
    }
  }

  void enqueueTilesFromBottom(ArrayDeque<Tile> queue, int col) {
    queue.clear();
    // Add tiles
    for (int i=3; i>=0; i--) {
      int id = grid.getID(i, col);
      if (grid.checkIfOccupied(id)) {
        Tile curTile = grid.peek(id);
        queue.add(curTile);
      }
    }
  }

  void moveTilesFromQueue(ArrayDeque<Tile> queue, String dir) {
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

  void lockMovement() {
    if (allDoneMoving()) {
      keyHandler.put(RIGHT, false);
      keyHandler.put(LEFT, false);
      keyHandler.put(UP, false);
      keyHandler.put(DOWN, false);
    }
  }

  void randTile() {
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
    grid.setCurrentValue(tile);
    //return tile;
  }

  void specificTile(int val, int row, int col) {
    Tile tile = new Tile(val, row, col);
    grid.occupy(tile);
    grid.addCount(tile);
    grid.enqueue(tile);
    grid.setCurrentValue(tile);
    //return tile;
  }

  int getTileValue(int row, int col) {
    int id = gridNum*row+col;
    return tiles[id].value;
  }

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
    tiles[tile.tileID] = tile;
  }

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
    tiles[tile.tileID] = tile;
  }

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
    tiles[tile.tileID] = tile;
  }

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
    //tiles[tile.tileID] = tile;
  }

  //void mergeTiles(int id) {
  //  println("Size: "+str(grid.queueSize(id)));
  //  int value = grid.peek(id).value*2;
  //  int row = grid.peek(id).rowPos;
  //  int col = grid.peek(id).colPos;
  //  //grid.minusCount(tile);
  //  //grid.minusCount(tile);
  //  //Tile tile0 = grid.dequeue(tile);
  //  Tile tile0 = grid.peekFirst(id);
  //  println("Dequeued: "+str(tile0.tileID));
  //  tile0.disappear();
  //  //Tile tile1 = grid.dequeue(tile);
  //  Tile tile1 = grid.peekLast(id);
  //  println("Dequeued: "+str(tile1.tileID));
  //  tile1.disappear();
  //  println("Heeeeeeeeeeere: "+str(tile1.alpha));
  //  if (tile1.alpha == 0) {
  //    grid.minusCount(grid.peek(id));
  //    grid.minusCount(grid.peek(id));
  //    tile0 = grid.dequeue(grid.peek(id));
  //    tile1 = grid.dequeue(grid.peek(id));
  //    grid.vacant(id);
  //    println("I am here");
  //    println("Sizeeeeeeee: "+str(grid.queueSize(id)));
  //    //Tile mergedTile = specificTile(value, row, col);
  //    //println("Alpha: "+str(mergedTile.alpha));
  //    //tiles[mergedTile.tileID] = mergedTile;
  //  }
  //}

  void mergeTiles(int id) {
    int value = grid.peek(id).value*2;
    int row = grid.peek(id).rowPos;
    int col = grid.peek(id).colPos;
    grid.dequeue(id);
    grid.dequeue(id);
    specificTile(value, row, col);
  }

  int getRightDest(Tile tile) {
    if (tile.isAtRightEdge()) {
      //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is at right edge.");
      return tile.colPos;
    } else {
      //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is NOT at right edge.");
      int curCol = tile.colPos + 1;
      while (curCol <= 3) {
        //println("Checking tile at ["+str(tile.rowPos)+", "+str(curCol)+"]");
        if (grid.checkIfOccupied(tile.rowPos, curCol)) {
          //println("Tile at ["+str(tile.rowPos)+", "+str(curCol)+"] is occupied.");
          int rightTileID = gridNum*tile.rowPos + curCol;
          Tile rightTile = tiles[rightTileID];
          if (tile.sameValue(rightTile)) {
            //println("Tile at ["+str(rightTile.rowPos)+", "+str(rightTile.colPos)+"] has the same value.");
            tile.overlap = true;
            return curCol; // ADDED -1 FOR TESTING
          } else {
            //println("Tile at ["+str(rightTile.rowPos)+", "+str(rightTile.colPos)+"] has different value.");
            return curCol-1;
          }
        } else {
          //println("Tile at ["+str(tile.rowPos)+", "+str(curCol)+"] is NOT occupied.");
          curCol += 1;
        }
      }
      return curCol-1;
    }
  }

  int getLeftDest(Tile tile) {
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
          Tile leftTile = tiles[leftTileID];
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
          Tile topTile = tiles[topTileID];
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
