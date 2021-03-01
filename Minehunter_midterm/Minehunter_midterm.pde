Minehunter minehunter;
float padding = 0;
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

void draw() {
  background(255);
  minehunter.displayGame();
}

void keyPressed() {
  if (keyPressed) {
    if (key == 'f' || key == 'F') {
      minehunter.changeFlag();
    }
  }
}

void mouseClicked() {
  minehunter.reward.collectReward();
}
