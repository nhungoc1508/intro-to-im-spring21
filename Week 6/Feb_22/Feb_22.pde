//import processing.sound.*;
//SoundFile file;
//color bgColor;

//void setup() {
//  size(400, 400);
//  background(255);
//  bgColor = color(random(255), random(255), random(255));
    
//  // Load a soundfile from the /data folder of the sketch and play it back
//  file = new SoundFile(this, "0.aif");
//  //file.play();
//}      

//void loadSound(int num) {
//  String fileName = str(num) + ".aif";
//  file = new SoundFile(this, fileName);
//}

//void draw() {
//  background(bgColor);
//}

//void mouseClicked() {
//  bgColor = color(random(255), random(255), random(255));
//  file.stop();
//  int newNum = int(random(5));
//  loadSound(newNum);
//  //file.loop();
//  file.play();
//}

//=======================================

//float smoothValX = 0;
//float smoothValY = 0;

//void setup() {
//  size(640, 640);
//}
//void draw() {
//  background(255);
//  smoothValX += (mouseX-smoothValX) * .1;
//  smoothValY += (mouseY-smoothValY) * .1;
//  ellipse(smoothValX, smoothValY, 40, 40);
//}

//=======================================

import processing.sound.*;
SoundFile sound;
float volumeDest = 0;
float smoothVol = 0;

void setup() {
  size(640, 640);
  sound = new SoundFile(this, "soundfile2.wav");
  sound.amp(0);
  sound.loop();
}

void draw() {
  smoothVol += (volumeDest-smoothVol)*.01;
  sound.amp(smoothVol);
}

void mousePressed() {
  volumeDest = 1;
}

void mouseReleased() {
  volumeDest = 0;
}
