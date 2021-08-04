// The core of the Cyclical Cellular Automata engine

public class CCA {
  public int w;
  public int h;
  public int[][] states;
  public boolean wrap = true;
  public float threshold = 0.0;

  // Constructor
  public CCA (int _w, int _h) {
    this.w = _w;
    this.h = _h;
    this.states = new int[_w][_h];
  }
  
  // Methods
  public int[][] randomizeStates(int _qty_thresholds) {
    for (int r = 0; r < this.states[0].length; r++) {
      for (int c = 0; c < this.states.length; c++) {
        this.states[c][r] = round(random(_qty_thresholds));
      }
    }
    return this.states;
  }

  public int[][] evaluate(boolean[][] _neighborhood, int[] _origin, int[] _thresholds) {
    int qty_thresholds = _thresholds.length;
    int[][] new_states = new int[this.w][this.h]; // store next states
    for (int y = 0; y <this.h; y++) { // iterate over states
      for (int x= 0; x < this.w; x++) {
        int state = this.states[x][y]; // get state
        int nx = 0;
        int ny = 0;
        int neighbors = 0;
        for (int r = 0; r < _neighborhood[0].length; r++) { // iterate over the neighborhood
          for (int c = 0; c < _neighborhood.length; c++) {
            if (_neighborhood[c][r]) { // if the neighbor is being counted
              int x2 = c - _origin[0]; // subtract our the origin location
              int y2 = r - _origin[1];
              if ( !(x2 == 0 && y2 == 0) ) { // if the current location isn't the same as the origin
                nx = x+x2; // calculate the location of the neighbor
                ny = y+y2;
                if (wrap) { // wraps around the edges
                  nx =  (nx + this.states.length) % this.states.length;
                  ny =  (ny + this.states[0].length) % this.states[0].length;
                }
                if ( (nx >= 0 && nx < this.states.length) && (ny >=0 && ny < this.states[0].length )) { // check that we're still in bounds
                  if ((state+1)%qty_thresholds == this.states[nx][ny]) { // the value of the neighbor, if stat is n+1 % m, count it
                    neighbors++;
                  }
                }
              }
            }
          }
        }
        if (neighbors >= _thresholds[state % qty_thresholds] && random(1) >= this.threshold) { // compare to threshold set in rules and add in some randomness
          new_states[x][y] = (state + 1) % qty_thresholds;
        } else {
          new_states[x][y] = state;
        }
      }
    }
    this.states = new_states;
    return this.states;
  }

  PImage render(Palette _palette) {
    PImage render = createImage(this.w*zoom, this.h*zoom, RGB);
    for (int x = 0; x < this.w; x++) {
      for (int y = 0; y < this.h; y++) {
        color c = _palette.getSwatch(this.states[x][y]%thresholds.size()).getColor();
        for (int y2 = 0; y2 < zoom; y2++) {
          for ( int x2 = 0; x2 < zoom; x2++) {
            render.pixels[((x*zoom)+x2)+render.width*((y*zoom)+y2)]=c;
          }
        }
      }
    }
    return render;
  }
}
