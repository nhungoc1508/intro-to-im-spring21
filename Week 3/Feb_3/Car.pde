class Car {
  float posX, posY;
  float carWidth, carHeight;
  color carColor;
  float wheelWidth, wheelHeight;
  float speed;

  Car(float x, float y) {
    posX = x;
    posY = y;
    carWidth = random(50, 150);
    carHeight = carWidth/2.5;
    carColor = color(random(255), random(255), random(255));
    wheelWidth = carWidth * .2;
    wheelHeight = wheelWidth/2.5;
    speed = random(5, 30);
  }

  void drawCarBody() {
    fill(carColor);
    noStroke();
    rect(posX, posY, carWidth, carHeight);
  }

  void drawCarWheels() {
    fill(0);
    //left top wheel
    rect(posX-carWidth/2 + wheelWidth/2, posY - carHeight/2-wheelHeight/2, wheelWidth, wheelHeight);
    //right top wheel
    rect(posX+carWidth/2 - wheelWidth/2, posY - carHeight/2-wheelHeight/2, wheelWidth, wheelHeight);
    //left bottom wheel
    rect(posX-carWidth/2 + wheelWidth/2, posY + carHeight/2+wheelHeight/2, wheelWidth, wheelHeight);
    //right bottom wheel
    rect(posX+carWidth/2 - wheelWidth/2, posY + carHeight/2+wheelHeight/2, wheelWidth, wheelHeight);
  }

  void driveCar() {
    posX += speed;
  }

  void checkEdges() {
    if (posX > width+carWidth/2) {
      posX = -carWidth/2;
    }
  }

  void runCar() {
    drawCarBody();
    drawCarWheels();
    driveCar();
    checkEdges();
  }
}
