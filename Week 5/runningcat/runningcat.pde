PImage spritesheet;
PImage[] sprites;
//int direction = 1; // 0 up
int step = 0;
int x;
int y;
int speed = 3;
int mirror = 1;

void setup() {
  size(1280, 720);
  spritesheet = loadImage("runningcat.png");
  sprites = new PImage[8];

  int w = spritesheet.width/2;
  int h = spritesheet.height/4;

  for (int y=0; y < 4; y++) {
    for (int x=0; x< 2; x++) {
      sprites[2*y+x] = spritesheet.get(x*w, y*h, w, h);
    }
  }

  x = width/2;
  y = height/2;

  imageMode(CENTER);
}

void draw() {
  background(255);
  //look at sprite sheet to determine which direction is which
  if (frameCount%speed==0) {
    step = (step+1) % 8;
  }
  if (keyPressed) {
    if (keyCode == LEFT) {
      mirror = -1;
    }
    if (keyCode == RIGHT) {
      mirror = 1;
    }
  }
  pushMatrix();
  translate(x, y);
  scale(mirror, 1);
  image(sprites[step], 0, 0);
  popMatrix();
}
