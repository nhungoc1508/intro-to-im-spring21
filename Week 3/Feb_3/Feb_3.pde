//Car myCar1, myCar2;
//int nums[];
Car cars[];

void setup() {
  size(1280, 720);
  rectMode(CENTER);
  //myCar1 = new Car(random(width), random(height));
  //myCar2 = new Car(random(width), random(height));

  cars = new Car[5];
  for (int i=0; i<cars.length; i++) {
    cars[i] = new Car(random(width), random(height));
  }

  //nums = new int[10];
  //for (int i = 0; i < nums.length; i++) {
  //  nums[i] = int(random(100));
  //}
  //printArray(nums);
}

void draw() {
  background(255);
  //if (myCar1.posX < width) {
  //  myCar1.runCar();
  //} else {
  //  myCar2.runCar();
  //}
  for (int i=0; i<cars.length; i++) {
    cars[i].runCar();
  }
}
