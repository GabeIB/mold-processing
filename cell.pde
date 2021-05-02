class Cell {
  int[] root;
  int[] end;
  float food;
  float len;
  float direction; //in radians between 0 and 2pi

  String toString() {
    return "cell["+root[0]+","+root[1]+","+end[0]+","+end[1]+","+"]";
  }

  Cell(int[] p1, int[] p2){
    root = p1;
    end = p2;
    food = 0;
    len = sqrt(sq(root[0]-end[0])+sq(root[1]-end[1]));
    direction = getAngle(root, end);
  }

  Cell(int[] r, float l, float d){
    food = 0;
    len = l;
    direction = d;
    root = new int[]{r[0], r[1]};
    end = new int[]{int(r[0]+len*cos(direction)), int(r[1]-len*sin(direction))};
  }

  void display() {
    colorMode(RGB, 255);
    color c = color(255, 224, 133);
    stroke(c);
    line(root[0], root[1], end[0], end[1]);
  }

  void eat(float[][] nutrients) {
    for(int i=-60; i<=60; i++){
      for(int j=-60; j<=60; j++){
        float distance = sqrt(sq(i)+sq(j));
        float consumption = pow(2, -0.5*distance);
        if(end[0]+i < nutrients.length && end[0]+i >= 0 && end[1]+j < nutrients[0].length && end[1]+j >= 0){
          float totalConsumption = nutrients[end[0]+i][end[1]+j]*consumption;
          food += totalConsumption;
          nutrients[end[0]+i][end[1]+j] -= totalConsumption;
        }
      }
    }
    food -= 0.5;
  }

  Cell[] reproduce() {
    float energyNeeded = 25;
    if (food < energyNeeded){
      return new Cell[]{};
    } else {
      float r = random(1);
      if (r < 0.5) {
        float deltaTheta = random(-PI/8.0, PI/8.0);
        int len = int(random(5, 10));
        food -= energyNeeded;
        return new Cell[]{new Cell(this.end, len, this.direction+deltaTheta)};
      }
    }
    return new Cell[]{};
  }
}

float getAngle(int[] root, int[] end) {
  float deltaX = end[0]-root[0];
  float deltaY = root[1]-end[1];
  float theta;
  if (deltaX == 0) {
    theta = HALF_PI;
  } else {
    theta = atan(deltaY/deltaX);
  }
  if (deltaX < 0 && deltaY < 0) {
    theta += PI;
  } else if ( deltaX < 0 ) {
    theta += PI;
  } else if (deltaY < 0 ) {
    if(deltaX == 0){
      theta += PI;
    } else {
      theta += 2*PI;
    }
  }
  return theta;
}
