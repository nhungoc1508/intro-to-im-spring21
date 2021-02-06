int rectWidth = 8;

void setup() {
  size(640, 480);
  //noFill();
  rectMode(CENTER);
}

void draw() {
  background(255);
  
  for (int x=rectWidth/2; x<width; x+=rectWidth) {
    float y = height*.25;
    float noiseInput = frameCount*.01 + x*.005; // take the factors out as speeds or sth
    float noiseValue = noise(noiseInput);
    noiseValue -= .5;
    noiseValue *= 100;
    y += noiseValue;
    rect(x, y, rectWidth, 100);
  }
  
  for (int x=rectWidth/2; x<width; x+=rectWidth) {
    float y = height*.75;
    float noiseInput = frameCount*.01 + x*.001; // take the factors out as speeds or sth
    float noiseValue = noise(noiseInput);
    noiseValue = map(noiseValue, 0, 1, 0, TWO_PI);
    pushMatrix();
    translate(x, y);
    rotate(noiseValue);
    rect(0, 0, rectWidth, 100);
    popMatrix();
  }
}
