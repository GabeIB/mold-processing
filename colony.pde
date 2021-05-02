import java.util.LinkedList;
import java.util.Iterator;

class Colony {
  LinkedList<Cell> cells;
  LinkedList<Cell> deadCells;

  Colony(Cell c){
    cells = new LinkedList<Cell>();
    cells.addLast(c);
    deadCells = new LinkedList<Cell>();
  }

  void eat(float[][] nutrients) {
    for(Cell c : cells){
      c.eat(nutrients);
    }
  }

  void reproduce() {
    LinkedList<Cell> growth = new LinkedList<Cell>();
    for(Cell c : cells){
      Cell[] newCells = c.reproduce();
      for(int j = 0; j < newCells.length; j++){
        growth.addLast(newCells[j]);
      }
    }
    for(Cell c: growth){
      cells.addLast(c);
    }
  }

  void die() {
    for(Iterator<Cell> iter = cells.iterator(); iter.hasNext();){
      Cell c = iter.next();
      if (c.food < 1.0) {
        iter.remove();
        deadCells.addLast(c);
      }
    }
  }

  void display() {
    for(Cell c : cells){
      c.display();
    }
    for(Cell c : deadCells){
      c.display();
    }
  }

  void addCell(Cell c){
    cells.addLast(c);
  }
}
