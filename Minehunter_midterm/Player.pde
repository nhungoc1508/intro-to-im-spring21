class Player {
  PImage avatarPNG;
  PImage[][] avatar;
  int direction = 2; // 0 - down, 1 - left, 2 - right, 3 - up
  int step = 0;
  float x, y;
  int i, j;
  float midX, midY;

  float padding = 0;
  float boardWidth = (float(2)/float(3) * width) - (padding * 2);
  float boardHeight = height - (padding * 2);
  float cellSize = int(min((boardWidth / boardDim), (boardHeight / boardDim)));

  int speed = int(cellSize*.08);
  //int speed = 6;
  float finBoardSize = cellSize * boardDim;
  
  boolean autoMove = false;

  Player() {
    avatarPNG = loadImage("avatar1.png");
    avatar = new PImage[4][4];

    int w = avatarPNG.width/4;
    int h = avatarPNG.height/4;
    midX = w/2;
    midY = h/2;

    for (int y=0; y<4; y++) {
      for (int x=0; x<4; x++) {
        avatar[y][x] = avatarPNG.get(x*w, y*h, w, h);
      }
    }
    x = cellSize/2 + padding;
    y = cellSize/2 + padding;
    updateCoordinates();
  }

  void updateCoordinates() {
    // Board coordinates
    i = int(x / cellSize);
    j = int(y / cellSize);
  }

  void movePlayer() {
    if (keyPressed || autoMove == true) {
      if (keyCode == DOWN && y < finBoardSize-midY) {
        direction = 0;
        y += speed;
      }
      if (keyCode == LEFT && x > 0) {
        direction = 1;
        x -= speed;
      }
      if (keyCode == RIGHT && x < finBoardSize-midX) {
        direction = 2;
        x += speed;
      }
      if (keyCode == UP && y > 0) {
        direction = 3;
        y -= speed;
      }
      if (frameCount % speed == 0) {
        step = (step+1) % 4;
      }
    }
  }
   
  void displayPlayer() {
    imageMode(CENTER);
    image(avatar[direction][step], x, y);
    updateCoordinates();
  }
}
