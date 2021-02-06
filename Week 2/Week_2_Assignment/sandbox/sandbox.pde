int numOfSquares = 15;
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
  // noLoop();

  // Randomize rotation
  for (int i=squareSize/2; i<width; i+=squareSize) {
    for (int j=squareSize/2; j<height; j+=squareSize) {
      float distance = dist(i, j, mouseX, mouseY);
      float distFactor = 1/distance * 100;
      if (distance > squareSize*3) {
        distFactor *= .01;
      }
      float rotatingFactor = random(-PI/10, PI/10) * distFactor;
      float movingFactorX = random(-movingRange, movingRange) * distFactor;
      float movingFactorY = random(-movingRange, movingRange) * distFactor;
      
      if (colorOn) {
        noStroke();
        color squareColor = color(0, random(0, 100), 230);
        float alpha = 255 - map(distance, 0, width, 0, 255);
        //color squareColor = color(random(0, 255), random(0, 255), random(0, 255));
        //float alpha = 255/2 - map(distance, 0, width, 0, 255);
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
