int rectWidth = 8;
float speed = .01;

void setup() {
  size(640, 480);
  rectMode(CENTER);

  //for (int i = 0; i < 10; i++) {
  //  println(i);
  //}

  //int i = 0;
  //while (i < 10) {
  //  println(i);
  //  i++;
  //}
}

void draw() {
  background(255);
  for (int x = rectWidth/2; x < width; x+=rectWidth) {
    float y = height/2;
    // y += random(-10, 10); // Can take 2 params. [a, b)
    float noiseValue = noise(frameCount * speed + x*0.005);
    noiseValue -= .5;
    noiseValue *= 200;
    y += noiseValue;
    rect(x, y, rectWidth, 100);
  }
  // noLoop();
}

void keyPressed() {
  if (key == ' ') {
    loop();
    println(noise(frameCount));
  }
}
