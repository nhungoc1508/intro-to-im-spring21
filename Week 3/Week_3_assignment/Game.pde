class Game {
  Grid grid = new Grid();
  //ArrayList<Tile> tiles = new ArrayList<Tile>(16);
  Tile[] tiles = new Tile[16];
  int gridNum = 4;

  Game() {
    Tile tile0 = specificTile(4, 3, 0);
    Tile tile1 = specificTile(2, 0, 1);
    //Tile tile1 = randTile();
    //tiles.add(tile0.tileID, tile0);
    //tiles.add(tile1.tileID, tile1);
    tiles[tile0.tileID] = tile0;
    tiles[tile1.tileID] = tile1;
    //tiles[tile1.tileID] = tile1;
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
    Tile tile = tiles[12];
    tile.displayTile();
    tiles[1].displayTile();
    if (key == CODED) {
      if (keyCode == RIGHT) {
        int dest = getRightDest(tile);
        //println("Dest: " + str(dest));
        tile.moveTileH(dest);
      }
      if (keyCode == LEFT) {
        int dest = getLeftDest(tile);
        //println("Dest: " + str(dest));
        tile.moveTileH(dest);
      }
      if (keyCode == UP) {
        int dest = getTopDest(tile);
        //println("Dest: " + str(dest));
        tile.moveTileV(dest);
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
    grid.changeStatus(tile);
    grid.setCurrentValue(tile);
    return tile;
  }

  Tile specificTile(int val, int row, int col) {
    Tile tile = new Tile(val, row, col);
    grid.changeStatus(tile);
    grid.setCurrentValue(tile);
    return tile;
  }

  int getTileValue(int row, int col) {
    int id = gridNum*row+col;
    return tiles[id].value;
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

  //int getRightDest(Tile tile) {
  //  if (tile.isAtRightEdge()) {
  //    //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is at right edge.");
  //    return tile.colPos;
  //  } else {
  //    //println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is NOT at right edge.");
  //    int curCol = tile.colPos + 1;
  //    while (curCol <= 3) {
  //      //println("Checking tile at ["+str(tile.rowPos)+", "+str(curCol)+"]");
  //      if (grid.checkIfOccupied(tile.rowPos, curCol)) {
  //        //println("Tile at ["+str(tile.rowPos)+", "+str(curCol)+"] is occupied.");
  //        int rightTileID = gridNum*tile.rowPos + curCol;
  //        Tile rightTile = tiles[rightTileID];
  //        if (tile.sameValue(rightTile)) {
  //          //println("Tile at ["+str(rightTile.rowPos)+", "+str(rightTile.colPos)+"] has the same value.");
  //          return curCol;
  //        } else {
  //          //println("Tile at ["+str(rightTile.rowPos)+", "+str(rightTile.colPos)+"] has different value.");
  //          return curCol-1;
  //        }
  //      } else {
  //        //println("Tile at ["+str(tile.rowPos)+", "+str(curCol)+"] is NOT occupied.");
  //        curCol += 1;
  //      }
  //    }
  //    return curCol-1;
  //  }
  //}
}
