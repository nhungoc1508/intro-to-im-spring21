import java.util.Map;

class Game {
  Grid grid = new Grid();
  //ArrayList<Tile> tiles = new ArrayList<Tile>(16);
  Tile[] tiles = new Tile[16];
  int gridNum = 4;
  HashMap<Integer, Boolean> keyHandler = new HashMap<Integer, Boolean>();

  Game() {
    keyHandler.put(LEFT, false);
    keyHandler.put(RIGHT, false);
    keyHandler.put(UP, false);
    keyHandler.put(DOWN, false);

    Tile tile0 = specificTile(2, 1, 0);
    Tile tile1 = specificTile(2, 2, 0);
    //Tile tile1 = randTile();
    //tiles.add(tile0.tileID, tile0);
    //tiles.add(tile1.tileID, tile1);
    tiles[tile0.tileID] = tile0;
    tiles[tile1.tileID] = tile1;
  }

  void displayGame() {
    grid.displayGrid();
    displayTiles();
  }

  void displayTiles() {
    //for (int i=0; i<tiles.length; i++) {
    //  if (grid.checkIfOccupied(i)) {
    //    Tile tile = tiles[i];
    //    tile.displayTile();

    //    if (key == CODED) {
    //      if (keyCode == UP) {
    //        tile.moveTileV(2);
    //      }
    //      if (keyCode == RIGHT) {
    //        int dest = getRightDest(tile);
    //        println("Dest: " + str(dest));
    //        tile.moveTileH(dest);
    //      }
    //    }
    //  }
    //}
    Tile tile = tiles[4];
    Tile tile1 = tiles[8];
    tile.displayTile();
    tile1.displayTile();

    if (keyHandler.get(RIGHT)) {
      moveTileRight(tile);
      println(grid.checkCollision(tile));
      if (tile.doneMoving) {
        grid.changeStatus(tile1);
        moveTileRight(tile1);
      }
    }

    if (keyHandler.get(LEFT)) {
      moveTileLeft(tile);
      println(grid.checkCollision(tile));
      if (tile.doneMoving) {
        grid.changeStatus(tile1);
        moveTileLeft(tile1);
      }
    }

    if (keyHandler.get(UP)) {
      moveTileUp(tile);
      println(grid.checkCollision(tile));
      if (tile.doneMoving) {
        grid.changeStatus(tile1);
        moveTileUp(tile1);
      }
    }

    if (keyHandler.get(DOWN)) {
      moveTileDown(tile1);
      println(grid.checkCollision(tile1));
      if (tile1.doneMoving) {
        grid.changeStatus(tile);
        moveTileDown(tile);
      }
    }
  }

  Tile randTile() {
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
    return tile;
  }

  Tile specificTile(int val, int row, int col) {
    Tile tile = new Tile(val, row, col);
    grid.occupy(tile);
    grid.addCount(tile);
    grid.enqueue(tile);
    grid.setCurrentValue(tile);
    return tile;
  }

  int getTileValue(int row, int col) {
    int id = gridNum*row+col;
    return tiles[id].value;
  }

  void moveTileRight(Tile tile) {
    //tile.resetMovement();
    //grid.changeStatus(tile);
    //tile.moving = true;
    //int dest = tile.colPos;
    //if (tile.moving && !tile.doneMoving) {
    //  dest = getRightDest(tile);
    //}
    //tile.moveTileH(dest);
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
    //tile.resetMovement();
    //grid.changeStatus(tile);
    //tile.moving = true;
    //int dest = tile.colPos;
    //if (tile.moving && !tile.doneMoving) {
    //  dest = getLeftDest(tile);
    //}
    //tile.moveTileH(dest);
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
    tiles[tile.tileID] = tile;
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
            return curCol;
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
            return curCol;
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
            return curRow;
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
          Tile bottomTile = tiles[bottomTileID];
          if (tile.sameValue(bottomTile)) {
            //println("Tile at ["+str(bottomTile.rowPos)+", "+str(bottomTile.colPos)+"] has the same value.");
            //println("return"+str(curRow));
            return curRow;
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
