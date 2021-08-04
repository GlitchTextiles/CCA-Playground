public class ControlFrame extends PApplet {

  int w, h, x, y;
  PApplet parent;
  ControlP5 cp5;
  int lastRadio=-1;
  public ControlFrame(PApplet _parent, int _x, int _y, int _w, int _h) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    x=_x;
    y=_y;
    PApplet.runSketch(new String[]{parent.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setSize(w, h);
    surface.setLocation(x, y);
    cp5 = new ControlP5(this);
    frameRate(30);

    //---------------------------------------------
    // Basic GUI Elements

    cp5.addToggle("run")
      .setPosition(grid(0), grid(0))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("RUN")
      .plugTo(this, "runToggle")
      .setValue(0.0)
      ;
    cp5.getController("run").getCaptionLabel().align(CENTER, CENTER);

    cp5.addToggle("recordSequence")
      .setPosition(grid(1), grid(0))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("REC")
      .plugTo(this, "recordSequence")
      ;
    cp5.getController("recordSequence").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("saveImage")
      .setPosition(grid(2), grid(0))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("SAVE")
      .plugTo(parent, "saveImage")
      ;
    cp5.getController("saveImage").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("quit")
      .setPosition(grid(10), grid(0))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("QUIT")
      .plugTo(this, "exit")
      ;
    cp5.getController("quit").getCaptionLabel().align(CENTER, CENTER);

    //---------------------------------------------
    // Size and zoom GUI Elements

    cp5.addTextfield("typeCCAW")
      .setPosition(grid(0), grid(1))
      .setSize(guiObjectSize, guiObjectSize/2)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("enter\ncca w")
      .plugTo(this, "typeCCAW")
      ;

    cp5.addNumberbox("setCCAW")
      .setPosition(grid(1), grid(1))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setValue(cca_w)
      .setMultiplier(-1)
      .setRange(10, 2048)
      .setLabel("cca w")
      .plugTo(this, "setCCAW")
      ;
    cp5.getController("setCCAW").getCaptionLabel().align(CENTER, BOTTOM);

    cp5.addTextfield("typeCCAH")
      .setPosition(grid(2), grid(1))
      .setSize(guiObjectSize, guiObjectSize/2)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("enter\ncca h")
      .plugTo(this, "typeCCAH")
      ;

    cp5.addNumberbox("setCCAH")
      .setPosition(grid(3), grid(1))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setValue(cca_h)
      .setMultiplier(-1)
      .setRange(10, 2048)
      .setLabel("cca h")
      .plugTo(this, "setCCAH")
      ;
    cp5.getController("setCCAH").getCaptionLabel().align(CENTER, BOTTOM);

    cp5.addButton("applyResize")
      .setPosition(grid(4), grid(1))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("apply\nresize")
      .plugTo(parent, "applyResize")
      ;
    cp5.getController("applyResize").getCaptionLabel().align(CENTER, CENTER);

    cp5.addNumberbox("setZoom")
      .setPosition(grid(5), grid(1))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setDecimalPrecision(0)
      .setValue(zoom)
      .setMultiplier(-0.1)
      .setRange(1.0, 100.0)
      .setLabel("zoom")
      ;
    cp5.getController("setZoom").getCaptionLabel().align(CENTER, BOTTOM);

    cp5.addButton("applyZoom")
      .setPosition(grid(6), grid(1))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("apply\nzoom")
      .plugTo(parent, "applyZoom")
      ;
    cp5.getController("applyZoom").getCaptionLabel().align(CENTER, CENTER);

    cp5.addSlider("thresholdSlider")
      .setPosition(grid(3), grid(6))
      .setSize(grid(5)-2*guiBufferSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setRange(0.0, 1.0)
      .setLabel("threshold")
      .plugTo(this, "setThreshold")
      ;
    cp5.getController("thresholdSlider").getCaptionLabel().align(CENTER, CENTER);

    //---------------------------------------------
    // Gradient GUI Elements

    gradientColors = cp5.addRadioButton("gradientColors")
      .setPosition(grid(2), grid(3))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setItemsPerRow(8)
      .setSpacingColumn(guiBufferSize)
      .plugTo(this, "gradientColors")
      ;

    this.createGradient(qty_colors);

    cp5.addButton("removeGradientColor")
      .setPosition(grid(0), grid(3))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("color\n-")
      .plugTo(this, "removeGradientColor")
      ;
    cp5.getController("removeGradientColor").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("addGradientColor")
      .setPosition(grid(1), grid(3))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("color\n+")
      .plugTo(this, "addGradientColor")
      ;
    cp5.getController("addGradientColor").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("randomizeGradient")
      .setPosition(grid(10), grid(3))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("RAND\nCOLORS")
      .plugTo(this, "randomizeGradient")
      ;
    cp5.getController("randomizeGradient").getCaptionLabel().align(CENTER, CENTER);

    //---------------------------------------------
    // Neighborhood GUI Elements

    cp5.addButton("randomizeNeighborhood")
      .setPosition(grid(0), grid(10))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rand\nhood")
      .plugTo(this, "randomizeNeighborhood")
      ;
    cp5.getController("randomizeNeighborhood").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("randomizeNeighborhoodMatrixOrigin")
      .setPosition(grid(0), grid(11))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rand\nmatrix\norigin")
      .plugTo(this, "randomizeNeighborhoodMatrixOrigin")
      ;
    cp5.getController("randomizeNeighborhoodMatrixOrigin").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("randomizeNeighborhoodMatrix")
      .setPosition(grid(0), grid(12))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rand\nmatrix")
      .plugTo(this, "randomizeNeighborhoodMatrix")
      ;
    cp5.getController("randomizeNeighborhoodMatrix").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("randomizeNeighborhoodOrigin")
      .setPosition(grid(0), grid(13))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rand\norigin")
      .plugTo(this, "randomizeNeighborhoodOrigin")
      ;
    cp5.getController("randomizeNeighborhoodOrigin").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("addRow")
      .setPosition(grid(0), grid(8))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("add\nrow")
      .plugTo(this, "neighborhoodAddRow")
      ;
    cp5.getController("addRow").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("removeRow")
      .setPosition(grid(0), grid(7))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("remove\nrow")
      .plugTo(this, "neighborhoodRemoveRow")
      ;
    cp5.getController("removeRow").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("addColumn")
      .setPosition(grid(2), grid(6))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("add\ncolumn")
      .plugTo(this, "neighborhoodAddColumn")
      ;
    cp5.getController("addColumn").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("removeColumn")
      .setPosition(grid(1), grid(6))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("remove\ncolumn")
      .plugTo(this, "neighborhoodRemoveColumn")
      ;
    cp5.getController("removeColumn").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("decOriginR")
      .setPosition(grid(10), grid(7))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("origin\n-row")
      .plugTo(this, "neighborhoodDecOriginR")
      ;
    cp5.getController("decOriginR").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("incOriginR")
      .setPosition(grid(10), grid(8))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("origin\n+row")
      .plugTo(this, "neighborhoodIncOriginR")
      ;
    cp5.getController("incOriginR").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("decOriginC")
      .setPosition(grid(8), grid(6))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("origin\n-col")
      .plugTo(this, "neighborhoodDecOriginC")
      ;
    cp5.getController("decOriginC").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("incOriginC")
      .setPosition(grid(9), grid(6))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("origin\n+col")
      .plugTo(this, "neighborhoodIncOriginC")
      ;
    cp5.getController("incOriginC").getCaptionLabel().align(CENTER, CENTER);

    // Toggle objects are stored within the Neighborhood instance
    // not sure if this is a bad idea, but it works for now...
    for (int r = 0; r < neighborhood.matrix.length; r++) {
      for (int c = 0; c < neighborhood.matrix[0].length; c++) {
        neighborhood.matrix[c][r] = cp5.addToggle("row"+r+"col"+c)
          .setPosition(grid(c)+grid(1)-guiBufferSize, grid(r)+grid(7)-guiBufferSize)
          .setSize(guiObjectSize, guiObjectSize)
          .setColorForeground(guiForeground)
          .setColorBackground(guiBackground)
          .setColorActive(guiActive)
          .setDecimalPrecision(0)
          .setValue(0)
          .setLabel("")
          .show()
          ;
      }
    }

    this.randomizeNeighborhoodMatrix();

    //---------------------------------------------
    // State Rules

    this.createRules(qty_states);

    cp5.addButton("removeRule")
      .setPosition(grid(0), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rule\n-")
      .plugTo(this, "removeRule")
      ;
    cp5.getController("removeRule").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("addRule")
      .setPosition(grid(1), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rule\n+")
      .plugTo(this, "addRule")
      ;
    cp5.getController("addRule").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("decRules")
      .setPosition(grid(2), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rules\n-1")
      .plugTo(this, "decRules")
      ;
    cp5.getController("decRules").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("incRules")
      .setPosition(grid(3), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rules\n+1")
      .plugTo(this, "incRules")
      ;
    cp5.getController("incRules").getCaptionLabel().align(CENTER, CENTER);

    cp5.addNumberbox("setRules")
      .setPosition(grid(4), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setDecimalPrecision(0)
      .setValue(1)
      .setMultiplier(-0.1)
      .setRange(0.0, 10.0)
      ;
    cp5.getController("setRules").getCaptionLabel().align(CENTER, BOTTOM);

    cp5.addButton("randomizeRules")
      .setPosition(grid(5), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("RAND\nRULES")
      .plugTo(this, "randomizeRules")
      ;
    cp5.getController("randomizeRules").getCaptionLabel().align(CENTER, CENTER);

    cp5.addButton("randomizeCCA")
      .setPosition(grid(6), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("RAND\nCCA")
      .plugTo(this, "randomizeCCA")
      ;
    cp5.getController("randomizeCCA").getCaptionLabel().align(CENTER, CENTER);

    randomizeGradient();
  }

  public void draw() {
    background(backgroundColor);

    //render the gradient
    int gradientW = grid(11) - guiBufferSize - grid(0);
    int gradientH = grid(1) - 2*guiBufferSize;
    image(gradient.renderVertical(gradientW, gradientH), grid(0), grid(2));

    //render the neighborhood origin as a bounding box
    if ( neighborhood != null) {
      Toggle t = neighborhood.matrix[neighborhood.origin_c][neighborhood.origin_r];
      noFill();
      stroke(255);
      rect(t.getPosition()[0]-1, t.getPosition()[1]-1, t.getWidth()+1, t.getHeight()+1);
    }
    parent.redraw();
  }

  //---------------------------------------------
  // General functions

  public void saveImage() {
    cp5.getController("run").setValue(0.0);
    save_file();
  }

  public void recordSequence(boolean _theValue) {
    record_sequence(_theValue);
  }

  public void runToggle(float _value) {
    run = _value > 0.0 ? true:false;
  }

  public void randomizeCCA() {
    cca.randomizeStates(thresholds.size());
  }

  //---------------------------------------------
  // Scaling functions

  public void typeCCAW(String _value) {
    cp5.getController("setCCAW").setValue(parseInt(_value));
  }
  public void typeCCAH(String _value) {
    cp5.getController("setCCAH").setValue(parseInt(_value));
  }
  public void setCCAW(int _value) {
    cca_w = _value;
  }
  public void setCCAH(int _value) {
    cca_h = _value;
  }
  public void setZoom(float _value) {
    tempZoom = int(_value);
  }
  public void applyZoom() {
    cp5.getController("run").setValue(0.0);
    zoom = tempZoom;
    resizeCanvas();
  }
  public void applyResize() {
    cp5.getController("run").setValue(0.0);
    resizeCCA();
    resizeCanvas();
  }

  //---------------------------------------------
  // Neighborhood functions

  public void updateNeighborhoodGUI() {
    for (int r = 0; r < neighborhood.matrix.length; r++) {  
      for (int c = 0; c < neighborhood.matrix[0].length; c++) {
        if (r < neighborhood.rows && c < neighborhood.cols) {
          neighborhood.matrix[c][r]
            .setColorForeground(guiForeground)
            .setColorBackground(guiBackground)
            .setColorActive(guiActive)
            .unlock()
            ;
        } else {
          neighborhood.matrix[c][r]
            .setColorForeground(guiForegroundInactive)
            .setColorBackground(guiBackgroundInactive)
            .setColorActive(guiInactive)
            .lock()
            ;
        }
      }
    }
  }
  public void neighborhoodAddRow() {
    neighborhood.addRow();
    this.updateNeighborhoodGUI();
  }
  public void neighborhoodRemoveRow() {
    neighborhood.removeRow();
    this.updateNeighborhoodGUI();
  }
  public void neighborhoodAddColumn() {
    neighborhood.addColumn();
    this.updateNeighborhoodGUI();
  }
  public void neighborhoodRemoveColumn() {
    neighborhood.removeColumn();
    this.updateNeighborhoodGUI();
  }
  public void neighborhoodIncOriginC() {
    neighborhood.incOriginC();
    this.updateNeighborhoodGUI();
  }
  public void neighborhoodDecOriginC() {
    neighborhood.decOriginC();
    this.updateNeighborhoodGUI();
  }
  public void neighborhoodIncOriginR() {
    neighborhood.incOriginR();
    this.updateNeighborhoodGUI();
  }
  public void neighborhoodDecOriginR() {
    neighborhood.decOriginR();
    this.updateNeighborhoodGUI();
  }
  public void randomizeNeighborhood() {
    neighborhood.randomize();
    this.updateNeighborhoodGUI();
  }
  public void randomizeNeighborhoodMatrix() {
    neighborhood.randomizeMatrix();
    this.updateNeighborhoodGUI();
  }
  public void randomizeNeighborhoodOrigin() {
    neighborhood.randomizeOrigin();
    this.updateNeighborhoodGUI();
  }
  public void randomizeNeighborhoodMatrixOrigin() {
    neighborhood.randomizeMatrix();
    neighborhood.randomizeOrigin();
    this.updateNeighborhoodGUI();
  }

  //---------------------------------------------
  // Gradient functions

  // Gradient palette editor colorWheel logic
  public void gradientColors(int index) {
    if (index != -1) {
      if (index != lastRadio && lastRadio != -1) { 
        cp5.remove("ColorWheel_"+lastRadio);
        createColorWheel(index);
      } else {
        createColorWheel(index);
      }
    } else {
      cp5.remove("ColorWheel_"+lastRadio);
    }
    lastRadio = index;
  }

  // when a colorWheel is created
  public void createColorWheel(int index) {
    float[] position = gradientColors.getPosition();
    gradientPicker = cp5.addColorWheel("ColorWheel_"+index)
      .setPosition(position[0], position[1]+grid(1))
      .setSize(grid(4), grid(4))
      .setRGB(gradient.getColorHandle(index).getColor())
      .setLabel("")
      .onChange(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        color c = gradientPicker.getRGB();
        String name = theEvent.getController().getName();
        int index = parseInt(split(name, '_')[1]); // the index routes the values to the appropriate place
        gradientColors.getItem(index).setColorBackground(c);
        gradient.getColorHandle(index).setColor(c);
        updatePalette();
      }
    }
    );
  }
  public void createGradient(int _colors) {
    for (int i = 0; i < _colors; i++) {
      this.addGradientColor();
    }
  }
  public void addGradientColor() {
    gradientColors.deactivateAll();
    if (gradientPicker != null) cp5.remove(gradientPicker.getName());
    if (gradientColors.getItems().size() < 8) {
      gradientColors.addItem("gColor_"+gradientColors.getItems().size(), gradientColors.getItems().size());
      gradient.addColorHandle(color(int(random(256)), int(random(256)), int(random(256))));
      updateGradientColors();
      updatePalette();
    }
  }
  public void removeGradientColor() {
    gradientColors.deactivateAll();
    if (gradientPicker != null) cp5.remove(gradientPicker.getName());
    if (gradientColors.getItems().size() > 2) {
      Toggle t = gradientColors.getItem(gradientColors.getItems().size()-1);
      this.cp5.remove(t.getName());
      gradientColors.removeItem(t.getName());
      gradient.removeColorHandle();
    }
    updatePalette();
  }
  public void updateGradientColors() {
    for (int i = 0; i < gradient.colorHandles.size(); i++) {
      color c = gradient.getColorHandle(i).getColor();
      gradientColors.getItem(i).setColorBackground(c).setLabel("");
    }
  }
  public void randomizeGradient() {
    gradient.randomizeColors();
    updateGradientColors();
    updatePalette();
  }
  public void updatePalette() {
    for (int i = 0; i < palette.size(); i++) {
      color c1 = gradient.getColor(i/float(palette.size()-1));
      color c2;
      palette.getSwatch(i).setColor(c1);
      if (brightness(c1) > 192) {
        c2 = color(0);
      } else {
        c2 = color(255);
      }
      thresholds.get(i).setColorBackground(c1).setColorValue(c2);
    }
  }
  
  //---------------------------------------------
  // Threshold/Rule Functions

  public void createRules(int _qty_states) {
    for (int i = 0; i < _qty_states; i++) {
      this.addRule();
    }
  }
  public void setRules(float value) {
    for (Numberbox n : thresholds) {
      n.setValue(int(value));
    }
  }
  public void decRules() {
    for (Numberbox n : thresholds) {
      n.setValue(max(n.getValue()-1, 0.0));
    }
  }
  public void incRules() {
    for (Numberbox n : thresholds) {
      n.setValue(n.getValue()+1);
    }
  }
  public void addRule() {
    if (thresholds.size() < 11) {
      thresholds.add(this.cp5.addNumberbox("rule_"+thresholds.size())
        .setPosition(grid(thresholds.size()), grid(5))
        .setSize(guiObjectSize, guiObjectSize)
        .setColorForeground(guiForeground)
        .setColorBackground(guiBackground)
        .setColorActive(guiActive)
        .setDecimalPrecision(0)
        .setValue(1)
        .setMultiplier(-0.1)
        .setRange(0.0, 10.0)
        .setLabel("")
        );
      thresholds.get(thresholds.size()-1).getValueLabel().setSize(12);
      palette.add();
      updatePalette();
    }
  }
  public void removeRule() {
    if (thresholds.size() > 2) {
      Numberbox n=thresholds.get(thresholds.size()-1);
      this.cp5.remove(n.getName());
      thresholds.remove(thresholds.size()-1);
      palette.remove();
      updatePalette();
    }
  }
  public void randomizeRules() {
    for (Numberbox n : thresholds) {
      n.setValue(round(random(neighborhood.getActiveNeighbors())));
    }
  }
  public void setThreshold(float _value) {
    cca.threshold=_value;
  }
}
