boolean testCell() {
  if (!testCreateCell()){
    println("testCreateCell failed");
    return false;
  }
  return true;
}

boolean testCreateCell() {
  Cell c0 = new Cell(new int[]{30,30}, 10, .64);
  if (!testCellEquals(c0, new int[]{30,30}, new int[]{38, 24}, 10, .64)){
    println("create cell radial coords failed");
    return false;
  }

  Cell c1 = new Cell(new int[]{30,30}, new int[]{38, 24});
  if (!testCellEquals(c1, new int[]{30,30}, new int[]{38, 24}, 10, .6435)){
    println("create cell cartesian coords failed");
    return false;
  }

  Cell c2 = new Cell(new int[]{30,30}, new int[]{30, 35});
  if (!testCellEquals(c2, new int[]{30,30}, new int[]{30, 35}, 5, 3*PI/2)){
    println("create cell cartesian coords failed");
    return false;
  }

  return true;
}

boolean testCellEquals(Cell c, int[] root, int[] end, float len, float direction) {
  if (c.root[0] != root[0]){
    println("expected root x = "+root[0]+" got "+c.root[0]);
    return false;
  }
  if (c.root[1] != root[1]){
    println("expected root y = "+root[1]+" got "+c.root[1]);
    return false;
  }
  if (c.end[0] != end[0]){
    println("expected end x = "+end[0]+" got "+c.end[0]);
    return false;
  }
  if (c.end[1] != end[1]){
    println("expected end y = "+end[1]+" got "+c.end[1]);
    return false;
  }
  if (c.len != len) {
    println("expected len = "+len+" got "+c.len);
    return false;
  }
    if (abs(c.direction - direction) > .01) {
    println("expected direction = "+direction+" got "+c.direction);
    return false;
  }
  return true;
}
