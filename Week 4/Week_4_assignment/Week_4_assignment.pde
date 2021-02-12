import java.util.Map;

Table table;
int numRow;
float monthWidth;
HashMap<String, Integer> interestByMonth = new HashMap<String, Integer>();
HashMap<String, ArrayList<Integer>> weekStacked = new HashMap<String, ArrayList<Integer>>();
HashMap<String, Integer> numOfWeeks = new HashMap<String, Integer>();
ArrayList<String> nameOfMonths = new ArrayList<String>();
int maxInterest = 0;

void setup() {
  size(1280, 720);
  loadData();
  breakData();
  printData();
  monthWidth = width/nameOfMonths.size();
}

void draw() {
  background(255);
  noStroke();
  drawMonths();
}

void loadData() {
  table = loadTable("multiTimeline.csv", "csv");
  numRow = table.getRowCount();
}

void breakData() {
  for (int i=0; i<numRow; i++) {
    TableRow row = table.getRow(i);
    String time = row.getString(0);
    // date in the form of "YYYY-MM-DD"
    //                     -0123456789-
    String month = time.substring(0, 7);
    int interest = row.getInt(1);
    if (interest > maxInterest) {
      maxInterest = interest;
    }
    if (!interestByMonth.containsKey(month)) {
      interestByMonth.put(month, 0);
      ArrayList<Integer> listOfWeeks = new ArrayList<Integer>();
      weekStacked.put(month, listOfWeeks);
      nameOfMonths.add(month);
    }
    int oldValue = interestByMonth.get(month);
    interestByMonth.put(month, oldValue+interest);

    ArrayList<Integer> listOfWeeks = weekStacked.get(month);
    listOfWeeks.add(interest);
    weekStacked.put(month, listOfWeeks);

    numOfWeeks.putIfAbsent(month, 0);
    int oldNumOfWeeks = numOfWeeks.get(month);
    numOfWeeks.put(month, oldNumOfWeeks+1);
  }
}

float drawEachMonth(String month, int order) {
  int interest = interestByMonth.get(month);
  float monthHeight = map(interest, 0, 300, 0, height); // the 300 is hardcoded
  float colorFactor = map(interest, 0, 300, 0, 255);
  color strokeColor = color(colorFactor, 150, 200);
  int alpha = 255;
  noStroke();
  if (int(mouseX / monthWidth) == order) {
    stroke(strokeColor);
    alpha = 0;
  }
  fill(colorFactor, 150, 200, alpha);
  rect(order*monthWidth, height-monthHeight, monthWidth, monthHeight);
  text(month, order*monthWidth, height-monthHeight);
  return monthHeight;
}

void drawMonths() {
  for (int i=0; i<nameOfMonths.size(); i++) {
    String month = nameOfMonths.get(i);
    float monthHeight = drawEachMonth(month, i);
    //drawWeeks(month, i, monthHeight);
  }
}

void drawWeeks(String month, int order, float monthHeight) {
  ArrayList<Integer> weekList = weekStacked.get(month);
  ArrayList<Float> weekHeights = new ArrayList<Float>();
  int numWeek = weekList.size();

  // Populate array of week heights w.r.t month height
  int monthInterest = interestByMonth.get(month);
  for (int i=0; i<numWeek; i++) {
    int curInterest = weekList.get(i);
    float ratio = float(curInterest)/float(monthInterest);
    float weekHeight = monthHeight * ratio;
    weekHeights.add(weekHeight);
  }

  for (int i=0; i<numWeek; i++) {
    float aggHeight = 0;
    for (int j=0; j<i; j++) {
      aggHeight += weekHeights.get(j);
    }
    String weekLabel = "Week " + str(i+1);
    fill(0);
    stroke(255);
    rect(order*monthWidth, height-aggHeight, monthWidth, weekHeights.get(i));
    text(weekLabel, order*monthWidth, height-aggHeight);
  }

  for (int i=0; i<numWeek; i++) {
    println(weekHeights.get(i));
  }
  //String weekLabel = "Week " + str(i+1);
  //fill(0);
  //stroke(255);
  //rect(order*monthWidth, height-weekHeight, monthWidth, weekList.get(i));
  //text(weekLabel, order*monthWidth, height-weekHeight);
}

void printData() {
  //for (Map.Entry month : interestByMonth.entrySet()) {
  //  print(month.getKey() + " ");
  //  println(month.getValue());
  //}
  //for (Map.Entry month : numOfWeeks.entrySet()) {
  //  print(month.getKey() + " ");
  //  println(month.getValue());
  //}
  //ArrayList<Integer> temp = weekStacked.get("2020-03");
  //for (int i=0; i<temp.size(); i++) {
  //  println("Week "+str(i)+": "+str(temp.get(i)));
  //}
  //float monthHeight = drawEachMonth("2020-01", 0);
  //drawWeeks("2020-01", 1, monthHeight);
  //println("Mouse: "+str(height-mouseX));
}
