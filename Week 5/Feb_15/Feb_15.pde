PImage img, ig;
//float w, h;
int tileSize = 200;

void setup() {
  size(1280, 720);
  img = loadImage("aiweiwei.jpeg");
  println(img.width, img.height);
  ig = img.get(int(random(img.width-tileSize)), int(random(img.height-tileSize)), tileSize, tileSize);
  //ig = img.get(-155, 1201-200, tileSize, tileSize);
  //imageMode(CENTER);
}

void draw() {
  // Nice way to get a color palette
  image(img, 0, 0);
  color c = get(mouseX, mouseY);
  //println(red(c), green(c), blue(c));
  
  //loadPixels();
  //for (int i=0; i<pixels.length; i++) {
  //  pixels[i] = color(random(255), 0, 50);
  //}
  //updatePixels();
  //for (int y=0; y<height; y++) {
  //  for (int x=0; x<width; x++) {
  //    int index = x + y * width;
  //    //float r = map(x, 0, width, 0, 255);
  //    //pixels[index] = color(100, 150, r); nice gradient
  //    float r = map(noise(x*.005, y*.005, frameCount*.01), 0, 1, 0, 255);
  //    pixels[index] = color(r);
  //  }
  //}
  //updatePixels();
  
  //float amount = 10;
  //float angle = 0;
  //float circDiv = TWO_PI/amount;
  //translate(width/2, height/2);
  //for (int i=0; i<amount; i++) {
  //  float x, y;
  //  x = cos(angle) * tileSize;
  //  y = sin(angle) * tileSize;
  //  pushMatrix();
  //  translate(x, y);
  //  rotate(angle);
  //  image(ig, 0, 0, tileSize, tileSize);
  //  popMatrix();
  //  angle += circDiv;
  //}
  
  //for (int y=0; y<height; y+= 64) {
  //  for (int x=0; x<width; x+= 64) {
  //    //PImage ig = img.get(x, y, 64, 64);
  //    image(ig, x, y, 64, 64);
  //  }
  //}
}
