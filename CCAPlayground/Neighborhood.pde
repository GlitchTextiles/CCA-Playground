public class Neighborhoods {

  ArrayList<Neighborhood> neighborhoods;

  Neighborhoods() {
    neighborhoods = new ArrayList<Neighborhood>();
  }

  public Neighborhoods addNeighborhood() {
    neighborhoods.add(new Neighborhood());
    return this;
  }

  public Neighborhood getNeighborhood(int _index) {
    if (_index < this.neighborhoods.size()) {
      return neighborhoods.get(_index);
    } else {
      return null;
    }
  }
}

public class Neighborhood {

  public int rows=2;
  public int cols=2;
  public int origin_r=0;
  public int origin_c=0;
  protected int qty_elements=9;
  public Toggle[][] matrix;

  public Neighborhood() {
    this.matrix = new Toggle[this.qty_elements][this.qty_elements];
  }

  public void randomize() {
    this.rows = round(random(1.0, this.qty_elements));
    this.cols = round(random(1.0, this.qty_elements));
    this.randomizeMatrix();
    this.randomizeOrigin();
  }

  public void randomizeMatrix() {
    for (int r = 0; r < this.rows; r++) {  
      for (int c = 0; c < this.cols; c++) {
        matrix[c][r].setValue(round(random(1)));
      }
    }
  }

  public void randomizeOrigin() {
    this.origin_r=int(random(this.rows));
    this.origin_c=int(random(this.cols));
  }

  public void addRow() {
    if (rows < this.matrix.length) ++rows;
  }

  public void removeRow() {
    if (rows > origin_r+1) --rows;
  }

  public void addColumn() {
    if (cols < this.matrix[0].length) ++cols;
  }

  public void removeColumn() {
    if (cols > origin_c+1) --cols;
  }

  public void decOriginR() {
    if ( origin_r > 0 ) --origin_r;
  }

  public void incOriginR() {
    if ( origin_r < rows-1 ) ++origin_r;
  }

  public void decOriginC() {
    if ( origin_c > 0 ) --origin_c;
  }

  public void incOriginC() {
    if ( origin_c < cols-1 ) ++origin_c;
  }

  public int[] getOrigin() {
    int[] origin = { origin_c, origin_r };
    return origin;
  }

  public Neighborhood get() {
    return this;
  }

  public Neighborhood copy() {
    Neighborhood copy = new Neighborhood();
    copy.rows=this.rows;
    copy.cols=this.cols;
    copy.origin_r=this.origin_r;
    copy.origin_c=this.origin_c;
    for (int r = 0; r < this.matrix[0].length; r++) {  
      for (int c = 0; c < this.matrix.length; c++) {
        copy.matrix[c][r]=this.matrix[c][r];
      }
    }
    return copy;
  }

  public boolean[][] getNeighborhoodValues() {
    boolean[][] values = new boolean[cols][rows];
    for (int r = 0; r < values[0].length; r++) {  
      for (int c = 0; c < values.length; c++) {
        values[c][r] = matrix[c][r].getValue() > 0.0 ? true:false;
      }
    }
    return values;
  }

  public int getActiveNeighbors() {
    int total=0;
    for (int r = 0; r < rows; r++) {  
      for (int c = 0; c < cols; c++) {
        total += int(matrix[c][r].getValue());
      }
    }
    return total;
  }
}
