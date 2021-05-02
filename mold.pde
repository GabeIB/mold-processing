
float[][] nutrients; // 1 is full nutrients 0 is no nutrients

float[][] initializeNutrients(int x, int y) {
  nutrients = new float[x][y];
  for(int i=0; i<nutrients.length ; i++) {
    for(int j=0; j<nutrients[i].length; j++) {
      nutrients[i][j] = 1;
    }
  }
  return nutrients;
}

//relies on the nutrients grid being the same size as the window
void drawNutrients(float[][] nutrients){
  color bg = color(252, 251, 212);
  color fg = color(79, 156, 88);
  loadPixels();
  for(int i=0; i<pixels.length; i++){
    int y = int(i/width);
    int x = i%width;
    float a = 255.0 * nutrients[x][y];
    color c = lerpColor(fg, bg, a); //set nutrient color here
    pixels[i] = c;
  }
  updatePixels();
}

Colony c;

void setup() {
  if (!testCell()) {
    println("tests failed");
    exit();
  }
  size(600, 600);
  nutrients = initializeNutrients(width, height);
  c = new Colony(new Cell(new int[]{300,300}, new int[]{299,300}));
  c.addCell(new Cell(new int[]{300,300}, new int[]{301,300}));
  c.addCell(new Cell(new int[]{300,300}, new int[]{300,299}));
  c.addCell(new Cell(new int[]{300,300}, new int[]{300,301}));
  c.addCell(new Cell(new int[]{300,300}, new int[]{301,301}));
  c.addCell(new Cell(new int[]{300,300}, new int[]{299,301}));
  c.addCell(new Cell(new int[]{300,300}, new int[]{299,299}));
  c.addCell(new Cell(new int[]{300,300}, new int[]{301,299}));
}

void draw() {
  c.eat(nutrients);
  c.die();
  c.reproduce();
  drawNutrients(nutrients);
  c.display();
  println(c.cells.size()+", "+c.deadCells.size());
  saveFrame("output2/#####_mold.png");
}

