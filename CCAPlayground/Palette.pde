//====================================================================================
// PaletteList Class
// Helper class to manage Palettes

public class PaletteList {

  public ArrayList<Palette> palettes;
  public ControlP5 controlContext;
  public ScrollableList paletteList;
  public Palette selection;

  public PaletteList(ControlP5 _controlContext) {
    controlContext = _controlContext;
    palettes = new ArrayList<Palette>();
    paletteList = controlContext.addScrollableList("select_palette")
      .setLabel("select palette")
      .setPosition(grid(0), grid(1))
      .setSize(grid(6)-2*guiBufferSize, grid(6))
      .setBarHeight(guiObjectSize)
      .setItemHeight(guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .plugTo(this, "select_palette")
      .setValue(0)
      .close()
      ;
  }

  public void select_palette(int _id) {
    this.selection = palettes.get(_id);
  }

  public PaletteList add(Palette _palette) {
    if (!this.palettes.contains(_palette)) {
      palettes.add(_palette);
      paletteList.addItem(_palette.name, _palette);
    }
    return this;
  }

  public Palette get() {
    return this.selection;
  }

  public Palette get(int _index) {
    if (_index < palettes.size() && _index >=0) {
      return palettes.get(_index);
    } else {
      println("[!] index "+_index+" out of range");
      return null;
    }
  }

  public Palette get(String _name) {
    for (Palette p : palettes) {
      if (p.name.equals(_name)) {
        return p;
      } else {
        println("[!] palette named \""+_name+"\" cannot be found");
        return null;
      }
    }
    println("[!] no palettes in this list");
    return null;
  }

  public PaletteList remove(String _name) {
    for (Palette p : palettes) {
      if (p.name.equals(_name)) {
        palettes.remove(p);
        paletteList.removeItem(_name);
      } else {
        println("[!] palette named \""+_name+"\" cannot be found");
      }
    }
    println("[!] no palettes in this list");
    return this;
  }

  public PaletteList remove(Palette _palette) {
    if (palettes.contains(_palette)) {
      palettes.remove(_palette);
      paletteList.removeItem(_palette.name);
    } else {
      println("[!] palette \""+_palette+"\" cannot be found");
    }
    return this;
  }
}

//====================================================================================
// Palette Class
// a palette is made up of swatches

public class Palette {

  public ArrayList<Swatch> palette;
  public String name;

  public Palette() {
    this.palette = new ArrayList<Swatch>();
    name = "New Palette";
  }

  public Palette(String _name) {
    this.palette = new ArrayList<Swatch>();
    this.name = _name;
  }

  public Palette(String _name, String[] hexes) {
    this.name = _name;
    this.palette = new ArrayList<Swatch>();
    for (String hex : hexes) {
      this.add(new Swatch(hex));
    }
  }

  public ArrayList<Swatch> randomize() {
    Collections.shuffle(this.palette);
    return this.palette;
  }

  public Palette copy() {
    Palette palette_copy = new Palette();
    for (Swatch s : this.palette) {
      palette_copy.add(s);
    }
    return palette_copy;
  }


  public Palette replacePalette(ArrayList<Swatch> palette) {
    this.palette=palette;
    return this;
  }
  
  public Palette add() {
    this.palette.add(new Swatch());
    return this;
  }

  public Palette add(color c) {
    this.palette.add(new Swatch(c));
    return this;
  }

  public Palette add(String hex) {
    this.palette.add(new Swatch(hex));
    return this;
  }

  public Palette add(Swatch swatch) {
    this.palette.add(swatch);
    return this;
  }

  public int size() {
    return this.palette.size();
  }

  public Swatch getSwatch(int swatch) {
    if (swatch >=0 && swatch < this.palette.size()) {
      return this.palette.get(swatch);
    } else {
      return new Swatch();
    }
  }

  public Palette remove() {
    this.palette.remove(palette.size()-1);
    return this;
  }

  public Palette remove(String hex) {
    boolean removed = false;
    for (Swatch s : this.palette) {
      if (s.hex.equals(hex)) {
        this.palette.remove(s);
      }
    }
    if (!removed) {
      println("Swatch " + hex+ " not found.");
    }
    return this;
  }

  public Swatch rand() {
    return this.palette.get(int(random(0, this.palette.size())));
  }

  public Swatch closest(color c) {
    Swatch candidate = new Swatch();
    for (Swatch s : this.palette) {
      if (s.avgDist(c) < candidate.avgDist(c)) {
        candidate = s;
      }
    }
    return candidate;
  }

  public Swatch closest(Swatch swatch) {
    Swatch candidate = new Swatch();
    for (Swatch s : this.palette) {
      if (s.avgDist(swatch) <= candidate.avgDist(swatch)) {
        candidate = s;
      }
    }
    return candidate;
  }

  public Swatch rgbClosest(color c) {
    Swatch candidate = new Swatch();
    for (Swatch s : this.palette) {
      if (s.rgbDist(c) <= candidate.rgbDist(c)) {
        candidate = s;
      }
    }
    return candidate;
  }

  public Swatch rgbClosest(Swatch swatch) {
    Swatch candidate = new Swatch();
    for (Swatch s : this.palette) {
      if (s.rgbDist(swatch) <= candidate.rgbDist(swatch)) {
        candidate = s;
      }
    }
    return candidate;
  }

  public Swatch hsbClosest(color c) {
    Swatch candidate = new Swatch();
    for (Swatch s : this.palette) {
      if (s.hsbDist(c) <= candidate.hsbDist(c)) {
        candidate = s;
      }
    }
    return candidate;
  }

  public Swatch hsbClosest(Swatch swatch) {
    Swatch candidate = new Swatch();
    for (Swatch s : this.palette) {
      if (s.hsbDist(swatch) <= candidate.hsbDist(swatch)) {
        candidate = s;
      }
    }
    return candidate;
  }

  public ArrayList<Swatch> getPalette() {
    return this.palette;
  }
}

//====================================================================================
// Swatch Class

public class Swatch {
  color c;
  float h;
  float s;
  float b;
  String hex;
  PVector rgbVect;
  PVector hsbVect;
  float hWeight = 2;
  float sWeight = 1;
  float bWeight = 1.5;

  public Swatch() {
    this.c = color(0);
    this.hex = hex(c);
    this.h = hue(this.c);
    this.s = saturation(this.c);
    this.b = brightness(this.c);
    this.rgbVect = new PVector( c >> 16 & 0xff, c >> 8 & 0xff, c >> 0 & 0xff);
    this.hsbVect = new PVector(hWeight*hue(c), sWeight*saturation(c), bWeight*brightness(c));
  }

  public Swatch(String hex) {
    this.hex = hex;
    this.c = unhex(hex);
    this.h = hue(this.c);
    this.s = saturation(this.c);
    this.b = brightness(this.c);
    this.rgbVect = new PVector( c >> 16 & 0xff, c >> 8 & 0xff, c >> 0 & 0xff);
    this.hsbVect = new PVector(hWeight*hue(c), sWeight*saturation(c), bWeight*brightness(c));
  }

  public Swatch(int c) {
    this.hex = hex(c);
    this.c = c;
    this.h = hue(this.c);
    this.s = saturation(this.c);
    this.b = brightness(this.c);
    this.rgbVect = new PVector( c >> 16 & 0xff, c >> 8 & 0xff, c >> 0 & 0xff);
    this.hsbVect = new PVector(hWeight*hue(c), sWeight*saturation(c), bWeight*brightness(c));
  }

  public float rgbDist(color c) {
    int r = c >> 16 & 0xff;
    int g = c >> 8 & 0xff;
    int b = c >> 0 & 0xff;
    return PVector.dist(this.rgbVect, new PVector(r, g, b));
  }

  public float rgbDist(Swatch s) {
    return PVector.dist(this.rgbVect, s.rgbVect);
  }

  public float hsbDist(color c) {
    return PVector.dist(this.hsbVect, new PVector(hWeight*hue(c), sWeight*saturation(c), bWeight*brightness(c)));
  }

  public float hsbDist(Swatch s) {
    return PVector.dist(this.hsbVect, s.hsbVect);
  }

  public float avgDist(color c) {
    return (this.rgbDist(c) + this.hsbDist(c))/2;
  }

  public float avgDist(Swatch s) {
    return (this.rgbDist(s) + this.hsbDist(s))/2;
  }

  public color getColor() {
    return this.c;
  }

  public float getHue() {
    return this.h;
  }

  public float getSaturation() {
    return this.s;
  }

  public float getBrightness() {
    return this.b;
  }

  public Swatch setColor(color _c) {
    this.hex = hex(_c);
    this.c = _c;
    this.h = hue(this.c);
    this.s = saturation(this.c);
    this.b = brightness(this.c);
    this.rgbVect = new PVector( this.c >> 16 & 0xff, this.c >> 8 & 0xff, this.c >> 0 & 0xff);
    this.hsbVect = new PVector(hWeight*hue(this.c), sWeight*saturation(this.c), bWeight*brightness(this.c));
    return this;
  }
}
