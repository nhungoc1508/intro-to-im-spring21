int numOfSquares = 15;
int mouseRadius = 3;
int squareSize;
float movingRange;
boolean colorOn = false;

void setup() {
  frameRate(10);

  size(900, 900);
  squareSize = width/numOfSquares;
  movingRange = squareSize*.1;
  print(squareSize);
  rectMode(CENTER);
}

void draw() {
  background(255);

  for (int i=squareSize/2; i<width; i+=squareSize) {
    for (int j=squareSize/2; j<height; j+=squareSize) {
      float distance = dist(i, j, mouseX, mouseY);
      float distFactor = 1/distance * 100;
      if (distance > squareSize*mouseRadius) {
        distFactor *= .01;
      }
      float rotatingFactor = random(-PI/10, PI/10) * distFactor;
      float movingFactorX = random(-movingRange, movingRange) * distFactor;
      float movingFactorY = random(-movingRange, movingRange) * distFactor;
      
      if (colorOn) {
        noStroke();
        color squareColor = color(random(0, 255), random(0, 255), random(0, 255));
        float alpha = map(distance, 0, width, 0, 255/2);
        fill(squareColor, alpha + random(-10, 10));
      }
      else {
        noFill();
        stroke(0);
      }
      pushMatrix();
      translate(i+movingFactorX, j+movingFactorY);
      rotate(rotatingFactor);
      rect(0, 0, squareSize, squareSize);
      popMatrix();
    }
  }
}

void mouseClicked() {
  colorOn = !colorOn;
}
