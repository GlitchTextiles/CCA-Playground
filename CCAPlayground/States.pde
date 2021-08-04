public class States {
  public int w;
  public int h;
  public int[][] states;
  public boolean wrap = true;
  public float threshold = 0.0;

  public States (int _w, int _h) {
    this.newStates(_w, _h);
  }

  public int[][] clearStates() {
    this.states = new int[w][h];
    return this.states;
  }

  public int[][] newStates(int _w, int _h) {
    this.w = _w;
    this.h = _h;
    this.states = new int[_w][_h];
    return this.states;
  }

  public int[][] randomStates(int _qty_thresholds) {
    for (int r = 0; r < this.states[0].length; r++) {
      for (int c = 0; c < this.states.length; c++) {
        this.states[c][r] = int(random(_qty_thresholds));
      }
    }
    return this.states;
  }

  public int[][] evaluate(boolean[][] _kernel, int[] _origin, int[] _thresholds) {
    int qty_thresholds = _thresholds.length;
    int[][] new_states = new int[this.w][this.h];
    for (int y = 0; y <this.h; y++) {
      for (int x= 0; x < this.w; x++) {
        int state = this.states[x][y];
        int nx = 0;
        int ny = 0;
        int neighbors = 0;
        for (int r = 0; r < _kernel[0].length; r++) {
          for (int c = 0; c < _kernel.length; c++) {
            if (_kernel[c][r]) {
              int x2 = c - _origin[0]; 
              int y2 = r - _origin[1];
              if ( !(x2 == 0 && y2 == 0) ) {
                nx = x+x2;
                ny = y+y2;
                if (wrap) {
                  nx =  (nx + this.states.length) % this.states.length;
                  ny =  (ny + this.states[0].length) % this.states[0].length;
                }
                if ( (nx >= 0 && nx < this.states.length) && (ny >=0 && ny < this.states[0].length )) {
                  if ((state+1)%qty_thresholds == this.states[nx][ny]) {
                    neighbors++;
                  }
                }
              }
            }
          }
        }
        if (neighbors >= _thresholds[state % qty_thresholds] && random(1) >= this.threshold) {
          new_states[x][y] = state+1;
          new_states[x][y] %= qty_thresholds;
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
