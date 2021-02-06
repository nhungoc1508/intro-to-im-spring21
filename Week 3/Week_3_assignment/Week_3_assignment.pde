Tile tile0, tile1, tile2, tile3, tile4;
ArrayList<Tile> tiles = new ArrayList<Tile>();
Cell cell0, cell1, cell2, cell3;
ArrayList<Cell> cells = new ArrayList<Cell>();
Game game;

void setup() {
  size(600, 600);
  game = new Game();
  tile0 = new Tile(2, 0, 1);
  tile1 = new Tile(2048, 2, 3);
  tile2 = new Tile(64, 0, 0);
  tile3 = new Tile(128, 3, 1);
  tile4 = new Tile(32, 1, 2);
  tiles.add(tile0);
  tiles.add(tile1);
  tiles.add(tile2);
  tiles.add(tile3);

  //cell0 = new Cell(0, 0);
  //cell1 = new Cell(0, 1);
  //cell2 = new Cell(0, 2);
  //cell3 = new Cell(0, 3);
  //cells.add(cell0);
  //cells.add(cell1);
  //cells.add(cell2);
  //cells.add(cell3);
}

void draw() {
  background(255);
  //noLoop();
  //testCell();
  //testGrid();
  //testTile();
  testGame();
}

void testGame() {
  //Game game = new Game();
  game.displayGame();
}

void testGrid() {
  Grid grid = new Grid();
  grid.displayGrid();
}

void testCell() {
  for (int i=0; i<cells.size(); i++) {
    Cell cell = cells.get(i);
    cell.displayCell();
  }
}

void testTile() {
  //for (Tile tile : tiles) {
  //  tile.displayTile();
  //}
  for (int i=0; i<tiles.size(); i++) {
    Tile tile = tiles.get(i);
    tile.displayTile();
  }
  //tile0.moveTileHorizontal(3);
  //tile0.moveTileH(3);
  //tile1.moveTileH(2);
  //tile2.moveTileV(3);
  //tile3.moveTileV(1);
  //tile1.moveTileVertical(1);
  //tiles.remove(0);

  //tile3.disappear();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      game.keyHandler.replace(RIGHT, true);
      game.keyHandler.replace(LEFT, false);
      game.keyHandler.replace(UP, false);
      game.keyHandler.replace(DOWN, false);
    }
    if (keyCode == LEFT) {
      game.keyHandler.replace(RIGHT, false);
      game.keyHandler.replace(LEFT, true);
      game.keyHandler.replace(UP, false);
      game.keyHandler.replace(DOWN, false);
    }
    if (keyCode == UP) {
      game.keyHandler.replace(RIGHT, false);
      game.keyHandler.replace(LEFT, false);
      game.keyHandler.replace(UP, true);
      game.keyHandler.replace(DOWN, false);
    }
    if (keyCode == DOWN) {
      game.keyHandler.replace(RIGHT, false);
      game.keyHandler.replace(LEFT, false);
      game.keyHandler.replace(UP, false);
      game.keyHandler.replace(DOWN, true);
    }
  }
}
