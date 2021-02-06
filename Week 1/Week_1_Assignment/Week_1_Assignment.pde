PShape portrait, face, upperHair, lowerHair, leftFringe, rightFringe, mouth, leftEye, rightEye, leftEyeball, rightEyeball;

int faceWidth = 180;
int faceHeight = 230;
int leftXOfFace;
int rightXOfFace;
color skinColor = color(255, 181, 159);

int hairWidth = faceWidth + 20;
int hairHeight = faceHeight + 20;
color hairColor = color(102, 58, 37);
int roundFactor = 30;

color mouthColor = color(165, 69, 68);

float eyeWidth;
float eyeHeight;

PShape drawEye(int x, int y) {
  /*
  * @param x,y coordinates of the upper left corner of the eye
  * @return PShape object of the eye
  */
  PShape eye = createShape(RECT, x, y, eyeWidth, eyeHeight, roundFactor);
  return eye;
}

PShape drawEyeball(int x, int y) {
  /*
  * @param x,y coordinates of the upper left corner of the eyeball
  * @return PShape object of the eyeball
  */
  PShape eyeball = createShape(RECT, x, y, eyeWidth*.5, eyeHeight*.5, roundFactor);
  return eyeball;
}

void setup() {
  size(640, 480);
  frameRate(30);
  
  leftXOfFace = width/2 - faceWidth/2;
  rightXOfFace = width/2 + faceWidth/2;
  eyeWidth = faceWidth*.2;
  eyeHeight = faceHeight*.2;
  
  portrait = createShape(GROUP);

  face = createShape(ELLIPSE, width/2, height/2, faceWidth, faceHeight);
  face.setFill(skinColor);
  face.setStroke(false);

  upperHair = createShape(ELLIPSE, width/2, height/2, hairWidth, hairHeight);
  upperHair.setFill(hairColor);
  upperHair.setStroke(false);

  lowerHair = createShape(RECT, leftXOfFace-10, height/2, hairWidth, faceHeight, 0, 0, roundFactor, roundFactor);
  lowerHair.setFill(hairColor);
  lowerHair.setStroke(false);
  
  leftFringe =  createShape(ELLIPSE, 0, 0, hairWidth*.75, hairHeight*.3);
  leftFringe.translate(width/2-faceWidth*.2, height/2-faceHeight*.28);
  leftFringe.rotate(-PI*.23);
  leftFringe.setFill(hairColor);
  leftFringe.setStroke(false);
  
  rightFringe = createShape(ELLIPSE, 0, 0, hairWidth*.6, hairHeight*.2);
  rightFringe.translate(width/2+faceWidth*.27, height/2-faceHeight*.28);
  rightFringe.rotate(PI*.28);
  rightFringe.setFill(hairColor);
  rightFringe.setStroke(false);

  mouth = createShape(ARC, width/2, height/2+faceWidth*.25, faceWidth*.5, faceHeight*.3, 0, PI, CHORD);
  mouth.setFill(mouthColor);
  mouth.setStroke(false);
  
  leftEye = drawEye(0, 0);
  leftEye.translate(width/2-faceWidth*.25-eyeWidth/2, height/2-faceHeight*.15);
  leftEye.setStroke(false);
  
  leftEyeball = drawEyeball(0, 0);
  leftEyeball.setFill(color(0, 0, 0));
  leftEyeball.translate(width/2-faceWidth*.25, height/2-faceHeight*.15+eyeHeight*.3);
  leftEyeball.setStroke(false);
  
  rightEye = drawEye(0, 0);
  rightEye.translate(width/2+faceWidth*.25-eyeWidth/2, height/2-faceHeight*.15);
  rightEye.setStroke(false);
  
  rightEyeball = drawEyeball(0, 0);
  rightEyeball.setFill(color(0, 0, 0));
  rightEyeball.translate(width/2+faceWidth*.25-eyeWidth/2, height/2-faceHeight*.15+eyeHeight*.3);
  rightEyeball.setStroke(false);
  
  // .addChild(): object added later will be placed on top
  portrait.addChild(upperHair);
  portrait.addChild(lowerHair);
  portrait.addChild(face);
  portrait.addChild(leftEye);
  portrait.addChild(rightEye);
  portrait.addChild(leftEyeball);
  portrait.addChild(rightEyeball);
  portrait.addChild(leftFringe);
  portrait.addChild(rightFringe);
  portrait.addChild(mouth);
}

// void blinkEyes() {
//  /* Create animation of eyes blinking
//  * @param None
//  * @return None
//  */
//  if (eyeHeight > 1) {
//    eyeHeight -= 2;
//  } else {
//    eyeHeight = faceHeight*.2;
//  }
//  eyes = createShape(GROUP);
//  leftEye = drawEye(0, 0);
//  leftEye.translate(width/2-faceWidth*.25-eyeWidth/2, height/2-faceHeight*.15);
//  leftEye.setStroke(false);
  
//  leftEyeball = drawEyeball(0, 0);
//  leftEyeball.setFill(color(0, 0, 0));
//  leftEyeball.translate(width/2-faceWidth*.25, height/2-faceHeight*.15+eyeHeight*.3);
//  leftEyeball.setStroke(false);
  
//  rightEye = drawEye(0, 0);
//  rightEye.translate(width/2+faceWidth*.25-eyeWidth/2, height/2-faceHeight*.15);
//  rightEye.setStroke(false);
  
//  rightEyeball = drawEyeball(0, 0);
//  rightEyeball.setFill(color(0, 0, 0));
//  rightEyeball.translate(width/2+faceWidth*.25-eyeWidth/2, height/2-faceHeight*.15+eyeHeight*.3);
//  rightEyeball.setStroke(false);
  
//  eyes.addChild(leftEye);
//  eyes.addChild(rightEye);
//  eyes.addChild(leftEyeball);
//  eyes.addChild(rightEyeball);
//  shape(eyes);
//}

void draw() {
  background(255);
  shape(portrait);
}
