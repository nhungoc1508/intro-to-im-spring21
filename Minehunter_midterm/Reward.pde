class Reward {
  int currentReward = 10;
  float padding = 0;
  float boardDim = 8;
  color cellColor = color(238, 228, 218);
  float boardWidth = (float(2)/float(3) * width) - (padding * 2);
  float boardHeight = height - (padding * 2);
  float cellSize = int(min((boardWidth / boardDim), (boardHeight / boardDim)));

  Reward() {
  }

  void collectReward() {
    currentReward += 2;
  }

  void loseReward() {
    currentReward -= 10;
  }

  void displayReward() {
    float x = width - padding - 4*cellSize;
    float y = padding;
    float w = cellSize*4;
    float h = cellSize*2;
    fill(cellColor);
    rect(x, y, w, h);
    fill(255);
    textSize(cellSize*.4);
    textAlign(CENTER, CENTER);
    String displayText = "YOUR POINTS\n" + str(currentReward);
    text(displayText, x+w/2, y+h/2);
  }
}
