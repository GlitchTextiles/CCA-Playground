// This Gradient class is a work in progress
// Currently 

public class Gradient {
  private ArrayList<AlphaHandle> alphaHandles;
  private ArrayList<ColorHandle> colorHandles;

  // Constructors
  public Gradient() {
    this.alphaHandles = new ArrayList<AlphaHandle>();
    this.colorHandles = new ArrayList<ColorHandle>();
  }

  public Gradient(int _qty_colors) {
    this.alphaHandles = new ArrayList<AlphaHandle>();
    this.colorHandles = new ArrayList<ColorHandle>();
    this.initHandles(_qty_colors);
  }

  // Initialization Methods
  public void initHandles(int _qty_handles) { // 
    int qty_handles = constrain(_qty_handles, 2, 64);
    alphaHandles.add(new AlphaHandle(0, 0));
    alphaHandles.add(new AlphaHandle(0, 255));
    for (int i = 0; i < qty_handles; i++ ) {
      colorHandles.add(new ColorHandle(color(int(random(256)), int(random(256)), int(random(256))), i/float(qty_handles-1)));
    }
    this.SortColorHandles();
    this.SortAlphaHandles();
  }

  // Add 
  public void addColorHandle() {
    this.colorHandles.add(new ColorHandle());
    this.updatePositions();
  }

  public void addColorHandle(color c) {
    this.colorHandles.add(new ColorHandle(c, 1.0));
    this.updatePositions();
  }

  // Remove
  public void removeColorHandle() {
    if (this.colorHandles.size() > 2) {
      this.colorHandles.remove(this.colorHandles.size()-1);
      this.updatePositions();
    }
  }

  // Evently spaces handle positions from 0.0 - 1.0
  public void updatePositions() {
    for (int i = 0; i < colorHandles.size(); i++) {
      ColorHandle ch = colorHandles.get(i);
      ch.setPosition(i/(float(colorHandles.size()-1)));
    }
  }

  // randomize existing colorHandle values
  public ArrayList<ColorHandle> randomizeColors() {
    for (ColorHandle ch : colorHandles) {
      ch.setColor(color(int(random(256)), int(random(256)), int(random(256))));
    }
    return this.colorHandles;
  }

  public ColorHandle getColorHandle(int _i) {
    return colorHandles.get(constrain(_i, 0, this.colorHandles.size()-1));
  }

  public ColorHandle setColorHandleValue(int _i, color _c) {
    ColorHandle ch = colorHandles.get(constrain(_i, 0, this.colorHandles.size()-1));
    ch.setColor(_c);
    return ch;
  }

  public PGraphics renderVertical(int _w, int _h) {//render the gradient
    PGraphics render = createGraphics(_w, _h);
    render.beginDraw();
    for (int i = 0; i < _w; i++) {
      render.stroke(gradient.getColor(i/float(_w)));
      render.line(i, 0, i, _h);
    }
    render.endDraw();
    return render;
  }

  public int getColor(float _i) {
    color c = color(0);
    for (int i = 0; i < this.colorHandles.size()-1; i++) {
      ColorHandle h1 = colorHandles.get(i);
      ColorHandle h2 = colorHandles.get(i+1); 
      float start = h1.getPosition();
      float end = h2.getPosition();
      if (i == 0 && _i <= h1.position) {
        c = h1.getColor();
        break;
      }
      if (i+1 == this.colorHandles.size()-1 && _i >= h2.position) {
        c = h2.getColor();
        break;
      }
      if (start == end) {
        c = h1.getColor();
        break;
      }
      if (_i >= start && _i <= end) {
        float distance = end - start;
        c = lerpColor(h1.getColor(), h2.getColor(), (_i-start)/distance);
        break;
      }
    }
    return c;
  }

  // Arranges colorHandles by position 0.0-1.0
  public void SortColorHandles() {
    Collections.sort(colorHandles, new SortByPosition());
  }

  public void SortAlphaHandles() { // need to implement alpha handles
    Collections.sort(alphaHandles, new SortByPosition());
  }

  public void getAlpha(float _i) { // need to implement alpha handles
  }

  public void getARGB(float _i) { // need to implement alpha handles
  }
}

// Alpha Handle Class

public class AlphaHandle extends Handle {

  private int alpha;

  public AlphaHandle(int _value, float _position) {
    this.alpha = min(max(_value, 0), 255);
    this.position = min(max(_position, 0.0), 1.0);
  }

  public int getAlpha() {
    return this.alpha;
  }

  public void setAlpha(int _value) {
    this.alpha = min(max(_value, 0), 255);
  }
}

// Color Handle Class

public class ColorHandle extends Handle {

  private color c;

  public ColorHandle() {
    this.c=color(0);
    this.position = 1.0;
  }

  public ColorHandle(color _c, float _position) {
    this.c=_c;
    this.position = min(max(_position, 0.0), 1.0);
  }

  public ColorHandle(int _r, int _g, int _b, float _position) {
    this.setColor(_r, _g, _b);
    this.position = min(max(_position, 0.0), 1.0);
  }

  public int getColor() {
    return this.c;
  }

  public int getR() {
    return this.c >> 16 & 0xFF;
  }

  public int getG() {
    return this.c >> 8 & 0xFF;
  }

  public int getB() {
    return this.c & 0xFF;
  }

  public void setColor(color _c) {
    this.c = _c;
  }

  public void setColor(int _r, int _g, int _b) {
    this.c = color(_r, _g, _b);
  }
}


// base class for gradient handles
public class Handle {
  protected float position;

  public float getPosition() {
    return this.position;
  }

  public void setPosition(float _value) {
    this.position = min(max(_value, 0.0), 1.0);
  }
}

// comparator for sorting by position
public class SortByPosition implements Comparator<Handle> {
  @Override
    public int compare(Handle h1, Handle h2) {
    return int((1000*h1.getPosition()) - (1000*h2.getPosition()));
  }
}
