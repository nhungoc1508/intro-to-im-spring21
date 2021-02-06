void setup() {
  size(640, 480);
}
// ----------------------------------
// Kinda Venn diagram
//noStroke();
//fill(0, 100, 230, 150);
//circle(width/2-50, height/2-50, 200);
//fill(100, 0, 230, 150);
//circle(width/2+50, height/2-50, 200);
//fill(0, 230, 100, 150);
//circle(width/2, height/2+50, 200);
// ----------------------------------
// ----------------------------------

void draw() {
  // Face
  background(255);
  noStroke();
  fill(255, 220, 177);
  ellipse(width/2, height/2, 175, 200);
  // Eyes
  fill(0);
  circle(width/2-35, height/2-25, 20);
  circle(width/2+35, height/2-25, 20);
  // Eyeballs
  fill(255);
  ellipse(width/2-35, height/2-25, 10, 20);
  ellipse(width/2+35, height/2-25, 10, 20);
  // Mouth
  stroke(5);
  strokeWeight(5);
  line(width/2-35, height/2+35, width/2+35, height/2+35);
}
