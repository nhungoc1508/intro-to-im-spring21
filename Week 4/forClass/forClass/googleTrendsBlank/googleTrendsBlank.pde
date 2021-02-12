Table table;
float spacing;

void setup() {
  size(1280, 720);
  loadData();
}

void loadData() {
  // Load CSV file into a Table object
  // "header" option indicates the file has a header row
  table = loadTable("multiTimeline.csv", "csv");
  // spacing is rowcount - 4 since the first three rows and the last row are superfluous
  spacing = float(width)/(table.getRowCount()-3);

}

void drawYear() {
  int totalYear = 1;
  float w = width/totalYear;
  for (int i=0; i<totalYear; i++) {
    fill(i, 0, 0, 255/2);
    rect(i*w, height-i, w, i);
  }
}

void draw() {
  background(255);
  // You can access iterate over all the rows in a table
  // start at row 3 since the first few rows are filler
  
  // scaffolding
  float w = width/table.getRowCount();
  for (int i = 3; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    // You can access the fields via their column name (or index)
    // interest in topic: range 0 - 100
    float interest = row.getFloat(1);
    fill(0, i, 0, 255/2);
    rect(i*w, height-interest, w, interest);
  }
  //drawYear();
}
