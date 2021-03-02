import processing.sound.*;
SoundFile newgameSound, flagSound, mineSound, safeSound;

Minehunter minehunter;
float padding = 0;
float boardDim = 8;
float boardWidth, boardHeight, cellSize;
color cellColor = color(238, 228, 218);
color playerColor = color(237, 207, 115);
color helpColor = color(237, 207, 115);
color tmpBomb = color(246, 124, 96);
boolean showingMines = false;
String screen = "welcome";
PFont font, quicksand;

void setup() {
  fullScreen();
  boardWidth = (float(2)/float(3) * width) - (padding * 2);
  boardHeight = height - (padding * 2);
  cellSize = int(min((boardWidth / boardDim), (boardHeight / boardDim)));
  minehunter = new Minehunter();
  
  font = createFont("PixelGameFont.ttf", 32);
  quicksand = createFont("Quicksand-Regular.ttf", 32);
  textFont(font);
  
  newgameSound = new SoundFile(this, "sounds/newgame.wav");
  flagSound = new SoundFile(this, "sounds/flag.wav");
  mineSound = new SoundFile(this, "sounds/mine.wav");
  safeSound = new SoundFile(this, "sounds/safe.wav");
}

void draw() {
  background(255);
  switch(screen) {
    case "welcome":
      minehunter.displayWelcome();
      break;
    case "howto":
      minehunter.displayHowto();
      break;
    case "game":
      minehunter.displayGame(true);
      break;
    case "win":
      minehunter.displayGame(false);
      minehunter.displayResult("win");
      break;
    case "lose":
      minehunter.displayGame(false);
      minehunter.displayMines();
      minehunter.displayResult("lose");
      break;
    case "newgame":
      minehunter = new Minehunter();
      minehunter.newGame();
      break;
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

void mousePressed() {
  if (screen == "game" && minehunter.displayHintButton()) {
    minehunter.getHint();
  }
}
