Minehunter minehunter;
float padding = 20;
float boardDim = 8;
float boardWidth, boardHeight, cellSize;

void setup() {
  size(600, 400);
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
      fill(180, 180, 180);
      rect(i*cellSize, j*cellSize, cellSize, cellSize);
    }
  }
}

void draw() {
  background(255);
  displayBoard();
}
