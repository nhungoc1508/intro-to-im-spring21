class Game {
  Grid grid = new Grid();
  //ArrayList<Tile> tiles = new ArrayList<Tile>(16);
  Tile[] tiles = new Tile[16];
  int gridNum = 4;

  Game() {
    Tile tile0 = specificTile(2, 0, 0);
    Tile tile1 = specificTile(4, 0, 2);
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
    Tile tile = tiles[0];
    tile.displayTile();
    tiles[2].displayTile();
    if (key == CODED) {
      if (keyCode == UP) {
        tile.moveTileV(2);
      }
      if (keyCode == RIGHT) {
        int dest = getRightDest(tile);
        println("Dest: " + str(dest));
        tile.moveTileH(dest);
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
      println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is at right edge.");
      return tile.colPos;
    } else {
      println("Tile at ["+str(tile.rowPos)+", "+str(tile.colPos)+"] is NOT at right edge.");
      int curCol = tile.colPos + 1;
      while (curCol <= 3) {
        println("Checking tile at ["+str(tile.rowPos)+", "+str(curCol)+"]");
        if (grid.checkIfOccupied(tile.rowPos, curCol)) {
          println("Tile at ["+str(tile.rowPos)+", "+str(curCol)+"] is occupied.");
          int rightTileID = gridNum*tile.rowPos + curCol;
          Tile rightTile = tiles[rightTileID];
          if (tile.sameValue(rightTile)) {
            println("Tile at ["+str(rightTile.rowPos)+", "+str(rightTile.colPos)+"] has the same value.");
            return curCol;
          } else {
            println("Tile at ["+str(rightTile.rowPos)+", "+str(rightTile.colPos)+"] has different value.");
            return curCol-1;
          }
        } else {
          println("Tile at ["+str(tile.rowPos)+", "+str(curCol)+"] is NOT occupied.");
          curCol += 1;
        }
      }
      return curCol-1;
    }
  }
}
