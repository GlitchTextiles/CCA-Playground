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
  public void initHandles(int _qty_handles) {
    int qty_handles = constrain(_qty_handles, 2, 64);
    alphaHandles.add(new AlphaHandle(0, 0));
    alphaHandles.add(new AlphaHandle(0, 255));
    for (int i = 0; i < qty_handles; i++ ) {
      colorHandles.add(new ColorHandle(color(int(random(256)), int(random(256)), int(random(256))), i/float(qty_handles-1)));
    }
    this.SortColorHandles();
    this.SortAlphaHandles();
  }
  
  // Add Methods
  public void addColorHandle() {
    this.colorHandles.add(new ColorHandle());
    this.updateLocations();
  }
  
  public void addColorHandle(color c) {
    this.colorHandles.add(new ColorHandle(c, 1.0));
    this.updateLocations();
  }
  
  // Remove
  public void removeColorHandle() {
    if (this.colorHandles.size() > 2) {
      this.colorHandles.remove(this.colorHandles.size()-1);
      this.updateLocations();
    }
  }

  public void updateLocations() {
    for (int i = 0; i < colorHandles.size(); i++) {
      ColorHandle ch = colorHandles.get(i);
      ch.setLocation(i/(float(colorHandles.size()-1)));
    }
  }

  public ArrayList<ColorHandle> randomizeColors() {
    for (ColorHandle ch : colorHandles) {
      ch.setColor(color(int(random(256)), int(random(256)), int(random(256))));
    }
    return this.colorHandles;
  }

  public ColorHandle getColorHandle(int _i) {
    return colorHandles.get(constrain(_i, 0, this.colorHandles.size()-1));
  }

  public ColorHandle setColorHandle(int _i, color _c) {
    ColorHandle ch = colorHandles.get(constrain(_i, 0, this.colorHandles.size()-1));
    ch.setColor(_c);
    return ch;
  }

  public int getColor(float _i) {
    color c = color(0);
    for (int i = 0; i < this.colorHandles.size()-1; i++) {
      ColorHandle h1 = colorHandles.get(i);
      ColorHandle h2 = colorHandles.get(i+1); 
      float start = h1.getLocation();
      float end = h2.getLocation();
      if (i == 0 && _i <= h1.location) {
        c = h1.getColor();
        break;
      }
      if (i+1 == this.colorHandles.size()-1 && _i >= h2.location) {
        c = h2.getColor();
        break;
      }
      if (start == end) {
        c = h1.getColor();
        break;
      }
      float distance = end - start;
      if (_i >= start && _i <= end) {
        c = lerpColor(h1.getColor(), h2.getColor(), (_i-start)/distance);
        break;
      }
    }
    return c;
  }

  public void getAlpha(float _i) {
  }

  public void getARGB(float _i) {
  }

  public void SortColorHandles() {
    Collections.sort(colorHandles, new SortByLocation());
  }

  public void SortAlphaHandles() {
    Collections.sort(alphaHandles, new SortByLocation());
  }
}


public class AlphaHandle extends Handle {

  private int alpha;

  public AlphaHandle(int _value, float _location) {
    this.alpha = min(max(_value, 0), 255);
    this.location = min(max(_location, 0.0), 1.0);
  }

  public int getAlpha() {
    return this.alpha;
  }

  public void setAlpha(int _value) {
    this.alpha = min(max(_value, 0), 255);
  }
}

public class ColorHandle extends Handle {

  private color c;
  
  public ColorHandle() {
    this.c=color(0);
    this.location = 1.0;
  }

  public ColorHandle(color _c, float _location) {
    this.c=_c;
    this.location = min(max(_location, 0.0), 1.0);
  }

  public ColorHandle(int _r, int _g, int _b, float _location) {
    this.setColor(_r, _g, _b);
    this.location = min(max(_location, 0.0), 1.0);
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

public class Handle {
  protected float location;

  public float getLocation() {
    return this.location;
  }

  public void setLocation(float _value) {
    this.location = min(max(_value, 0.0), 1.0);
  }
}

public class SortByLocation implements Comparator<Handle> {
  @Override
    public int compare(Handle h1, Handle h2) {
    return int((1000*h1.getLocation()) - (1000*h2.getLocation()));
  }
}
