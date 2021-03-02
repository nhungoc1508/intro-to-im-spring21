class Reward {
  int currentReward = 10;
  float padding = 0;
  float boardDim = 8;
  color cellColor = color(238, 228, 218);
  float boardWidth = (float(2)/float(3) * width) - (padding * 2);
  float boardHeight = height - (padding * 2);
  float cellSize = int(min((boardWidth / boardDim), (boardHeight / boardDim)));
  boolean alert = false;

  /**
   * Constructor of a reward object
   * No need for initializing
   * All attributes are fixed
   */
  Reward() {
  }

  /**
   * Add 2 points for each safe cell revealed
   */
  void collectReward() {
    currentReward += 2;
  }

  /**
   * Subtract 10 points for each hint used
   */
  void loseReward() {
    currentReward -= 10;
  }

  /**
   * Display player's point
   */
  void displayReward() {
    float x = width - padding - 4*cellSize;
    float y = padding;
    float w = cellSize*4;
    float h = cellSize*2;
    stroke(255);
    strokeWeight(2);
    fill(helpColor);
    rect(x, y, w, h);
    fill(255);
    textSize(cellSize*.4);
    textAlign(CENTER, CENTER);
    String displayText = "YOUR POINTS\n" + str(currentReward);
    text(displayText, x+w/2, y+h/2);
  }
}
