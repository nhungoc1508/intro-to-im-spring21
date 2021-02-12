String s = "Hello, world!";
PFont font;
float xPos;

void setup() {
  size(640, 480);
  //textSize(64);
  textAlign(CENTER);
  font = createFont("Courier New", 32);
  textFont(font);
  xPos = width;
}

void draw() {
  background(255);
  fill(170, 120, 70);
  //text(s, width/2, height/2);
  for (int i=0; i<s.length(); i++) {
    char c = s.charAt(i);
    float x = width/2 + i*textWidth(c);
    float y = height/2 + random(-3, 3);
    text(c, x, y);
  }
  
  //xPos -= 5;
  //if (xPos <= -textWidth(s)) {
  //  xPos = width;
  //}
}
