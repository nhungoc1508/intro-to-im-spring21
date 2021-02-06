class Game {
  Grid grid = new Grid();
  //ArrayList<Tile> tiles = new ArrayList<Tile>(16);
  Tile[] tiles = new Tile[16];
  int gridNum = 4;

  Game() {
    Tile tile0 = randTile();
    //Tile tile1 = randTile();
    //tiles.add(tile0.tileID, tile0);
    //tiles.add(tile1.tileID, tile1);
    tiles[tile0.tileID] = tile0;
    //tiles[tile1.tileID] = tile1;
  }

  void displayGame() {
    grid.displayGrid();
    displayTiles();
  }

  void displayTiles() {
    for (int i=0; i<tiles.length; i++) {
      if (grid.checkStatus(i)) {
        Tile tile = tiles[i];
        tile.displayTile();

        if (key == CODED) {
          if (keyCode == UP) {
            tile.moveTileV(2);
          }
          if (keyCode == RIGHT) {
            tile.moveTileH(3);
          }
        }
      }
    }
  }

  Tile randTile() {
    int randRow = floor(random(4));
    int randCol = floor(random(4));
    while (grid.checkStatus(randRow, randCol)) {
      randRow = floor(random(4));
      randCol = floor(random(4));
    }
    Tile tile = new Tile(2, randRow, randCol);
    grid.changeStatus(tile);
    grid.setCurrentValue(tile);
    return tile;
  }

  int getTileValue(int row, int col) {
    int id = gridNum*row+col;
    return tiles[id].value;
  }

  //int destMoveRight(Tile tile) {
  //  int destCol = tile.colPos;
  //  if (!tile.isAtRightEdge()) {
  //    int curCol = tile.colPos + 1;
  //    while (curCol <= 3) {
  //      if (grid.checkStatus(tile.rowPos, curCol)) {
  //        if (getTileValue(tile.rowPos, curCol) == tile.value) {
  //          return curCol;
  //        } else {
  //          return tile.colPos;
  //        }
  //      } else {
  //        if (curCol == 3) {
  //          return curCol;
  //        } else {
  //          curCol += 1;
  //        }
  //      }
  //    }
  //    return tile.colPos;
  //  }
  //}
}
