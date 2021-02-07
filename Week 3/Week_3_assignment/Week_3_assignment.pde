Tile tile0, tile1, tile2, tile3, tile4;
ArrayList<Tile> tiles = new ArrayList<Tile>();
Cell cell0, cell1, cell2, cell3;
ArrayList<Cell> cells = new ArrayList<Cell>();
Game game;

void setup() {
  size(600, 600);
  game = new Game();
}

void draw() {
  background(255);
  testGame();
}

void testGame() {
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
  for (int i=0; i<tiles.size(); i++) {
    Tile tile = tiles.get(i);
    tile.displayTile();
  }
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
