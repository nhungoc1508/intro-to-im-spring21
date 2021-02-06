//int centerX;
//int centerY;
//float speedX = 5;
//int directionX = 1;
//int speedY = 2;
//int radius = 50;

//void setup() {
//  size(640, 480);
//  frameRate(60);
//  centerX = width/2;
//  centerY = height/2;
//}

//void draw() {
//  background(255);
//  speedX = map(mouseX, 0, width, 1, 5);
//  centerX += speedX*directionX;
//  centerY += speedY;
  
//  ellipse(centerX, centerY, radius*2, radius*2);
  
//  if (centerX >= width-radius) {
//    directionX *= -1;
//  }
  
//  else if (centerX <= radius) {
//    directionX *= -1;
//  }
  
//  if (centerY >= height-radius) {
//    speedY *= -1;
//  }
  
//  else if (centerY <= radius) {
//    speedY *= -1;
//  }
//}

// --------------------------------------------

color red = color(255, 0, 0);
color white = color(255);

void setup() {
  size(640, 480);
}


int rectWidth = 200;
int rectHeight = 100;

void draw() {
  //if (mouseX > width/2) {
  //  background(red);
  //}
  //else {
  //  background(white);
  //}

  rectMode(CENTER);
  // See: rectMode(RADIUS);
  noStroke();
  rect(width/2, height/2, rectWidth, rectHeight);
}

void mousePressed() {
  if (mouseX >= width/2-rectWidth/2 && 
    mouseX <= width/2+rectWidth/2 && 
    mouseY >= height/2-rectHeight/2 && 
    mouseY <= height/2+rectHeight/2) {
    fill(red);
  }
}

void mouseReleased() {
  fill(white);
}
