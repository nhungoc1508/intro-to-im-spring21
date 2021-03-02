Minehunter minehunter;
float padding = 0;
float boardDim = 8;
float boardWidth, boardHeight, cellSize;
color cellColor = color(238, 228, 218);
color tmpBomb = color(246, 124, 96);
boolean showingMines = false;
String screen = "welcome";

void setup() {
  fullScreen();
  boardWidth = (float(2)/float(3) * width) - (padding * 2);
  boardHeight = height - (padding * 2);
  cellSize = int(min((boardWidth / boardDim), (boardHeight / boardDim)));
  minehunter = new Minehunter();
  PFont font = createFont("PixelGameFont.ttf", 32);
  textFont(font);
}

void draw() {
  background(255);
  switch(screen) {
    case "welcome":
      minehunter.displayWelcome();
      break;
    case "howto":
      break;
    case "game":
      minehunter.displayGame();
      break;
    case "win":
      minehunter.displayWin();
      break;
    //case "loss":
    //  minehunter.displayLoss();
    //  break;
  }
}

void keyPressed() {
  if (keyPressed) {
    if (key == 'f' || key == 'F') {
      minehunter.changeFlag();
    }
    if (key == ' ') {
      minehunter.revealCell();
    }
  }
}
