Minehunter minehunter;
float padding = 20;
float boardDim = 8;
float boardWidth, boardHeight, cellSize;
color cellColor = color(238, 228, 218);
color tmpBomb = color(246, 124, 96);
boolean showingMines = false;

void setup() {
  fullScreen();
  boardWidth = (float(2)/float(3) * width) - (padding * 2);
  boardHeight = height - (padding * 2);
  cellSize = int(min((boardWidth / boardDim), (boardHeight / boardDim)));
  minehunter = new Minehunter();
}

void displayBoard() {
  translate(padding, padding);
  for (int i=0; i<boardDim; i++) {
    for (int j=0; j<boardDim; j++) {
      stroke(255);
      strokeWeight(2);
      if (showingMines == true && minehunter.isMine(i, j)) {
        fill(tmpBomb);
      } else {
        fill(cellColor);
      }
      rect(i*cellSize, j*cellSize, cellSize, cellSize);
      if (showingMines == true && !minehunter.isMine(i, j)) {
        pushMatrix();
        translate(cellSize*.5, cellSize*.5);
        fill(0);
        textSize(cellSize*.4);
        textAlign(CENTER, CENTER);
        text(str(minehunter.numNeighborMines(i, j)), i*cellSize, j*cellSize);
        popMatrix();
      }
    }
  }
}

void draw() {
  background(255);
  displayBoard();
}

void keyPressed() {
  if (keyPressed) {
    showingMines = !showingMines;
  }
}
