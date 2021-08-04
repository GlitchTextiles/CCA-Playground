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
    //cp5.getFont().sharp();

    frameRate(30);

    // row 0 controls
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
    cp5.getController("run").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addToggle("recordSequence")
      .setPosition(grid(1), grid(0))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("REC")
      .plugTo(this, "recordSequence")
      ;
    cp5.getController("recordSequence").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("saveImage")
      .setPosition(grid(2), grid(0))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("SAVE")
      .plugTo(parent, "saveImage")
      ;
    cp5.getController("saveImage").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("quit")
      .setPosition(grid(10), grid(0))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("QUIT")
      .plugTo(this, "exit")
      ;
    cp5.getController("quit").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    //---------------------------------------------
    // Size stuff
    
     cp5.addTextfield("typeStatesW")
      .setPosition(grid(0), grid(1))
      .setSize(guiObjectSize, guiObjectSize/2)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("enter\nstates w")
      .plugTo(this, "typeStatesW")
      ;

    cp5.addNumberbox("setStatesW")
      .setPosition(grid(1), grid(1))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setValue(states_w)
      .setMultiplier(-1)
      .setRange(10, 2048)
      .setLabel("states w")
      .plugTo(this, "setStatesW")
      ;
    cp5.getController("setStatesW").getCaptionLabel().align(ControlP5.CENTER, BOTTOM);
    
    cp5.addTextfield("typeStatesH")
      .setPosition(grid(2), grid(1))
      .setSize(guiObjectSize, guiObjectSize/2)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("enter\nstates h")
      .plugTo(this, "typeStatesH")
      ;

    cp5.addNumberbox("setStatesH")
      .setPosition(grid(3), grid(1))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setValue(states_h)
      .setMultiplier(-1)
      .setRange(10, 2048)
      .setLabel("states h")
      .plugTo(this, "setStatesH")
      ;
    cp5.getController("setStatesH").getCaptionLabel().align(ControlP5.CENTER, BOTTOM);

    cp5.addButton("applyResize")
      .setPosition(grid(4), grid(1))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("apply\nresize")
      .plugTo(parent, "applyResize")
      ;
    cp5.getController("applyResize").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addNumberbox("setZoom")
      .setPosition(grid(5), grid(1))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setDecimalPrecision(0)
      .setValue(zoom)
      .setMultiplier(-0.1)
      .setRange(1.0, 10.0)
      .setLabel("zoom")
      ;
    cp5.getController("setZoom").getCaptionLabel().align(ControlP5.CENTER, BOTTOM);
    
    cp5.addButton("applyZoom")
      .setPosition(grid(6), grid(1))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("apply\nzoom")
      .plugTo(parent, "applyZoom")
      ;
    cp5.getController("applyZoom").getCaptionLabel().align(ControlP5.CENTER, CENTER);

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
    cp5.getController("thresholdSlider").getCaptionLabel().align(ControlP5.CENTER, CENTER);



    //---------------------------------------------
    // Gradient Controls

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
    cp5.getController("removeGradientColor").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("addGradientColor")
      .setPosition(grid(1), grid(3))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("color\n+")
      .plugTo(this, "addGradientColor")
      ;
    cp5.getController("addGradientColor").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("randomizeGradient")
      .setPosition(grid(10), grid(3))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("RAND\nCOLORS")
      .plugTo(this, "randomizeGradient")
      ;
    cp5.getController("randomizeGradient").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    //---------------------------------------------
    // KERNEL

    cp5.addButton("randomizeKernel")
      .setPosition(grid(0), grid(10))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rand\nkernel")
      .plugTo(this, "randomizeKernel")
      ;
    cp5.getController("randomizeKernel").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("randomizeKernelMatrix")
      .setPosition(grid(0), grid(11))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rand\nmatrix")
      .plugTo(this, "randomizeKernelMatrix")
      ;
    cp5.getController("randomizeKernelMatrix").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("randomizeKernelOrigin")
      .setPosition(grid(10), grid(10))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rand\norigin")
      .plugTo(this, "randomizeKernelOrigin")
      ;
    cp5.getController("randomizeKernelOrigin").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("addRow")
      .setPosition(grid(0), grid(8))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("add\nrow")
      .plugTo(this, "kernelAddRow")
      ;
    cp5.getController("addRow").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("removeRow")
      .setPosition(grid(0), grid(7))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("remove\nrow")
      .plugTo(this, "kernelRemoveRow")
      ;
    cp5.getController("removeRow").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("addColumn")
      .setPosition(grid(2), grid(6))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("add\ncolumn")
      .plugTo(this, "kernelAddColumn")
      ;
    cp5.getController("addColumn").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("removeColumn")
      .setPosition(grid(1), grid(6))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("remove\ncolumn")
      .plugTo(this, "kernelRemoveColumn")
      ;
    cp5.getController("removeColumn").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("decOriginR")
      .setPosition(grid(10), grid(7))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("origin\n-row")
      .plugTo(this, "kernelDecOriginR")
      ;
    cp5.getController("decOriginR").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("incOriginR")
      .setPosition(grid(10), grid(8))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("origin\n+row")
      .plugTo(this, "kernelIncOriginR")
      ;
    cp5.getController("incOriginR").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("decOriginC")
      .setPosition(grid(8), grid(6))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("origin\n-col")
      .plugTo(this, "kernelDecOriginC")
      ;
    cp5.getController("decOriginC").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("incOriginC")
      .setPosition(grid(9), grid(6))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("origin\n+col")
      .plugTo(this, "kernelIncOriginC")
      ;
    cp5.getController("incOriginC").getCaptionLabel().align(ControlP5.CENTER, CENTER);

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

    this.randomizeKernelMatrix();
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
    cp5.getController("removeRule").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("addRule")
      .setPosition(grid(1), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rule\n+")
      .plugTo(this, "addRule")
      ;
    cp5.getController("addRule").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("decRules")
      .setPosition(grid(2), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rules\n-1")
      .plugTo(this, "decRules")
      ;
    cp5.getController("decRules").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("incRules")
      .setPosition(grid(3), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground)
      .setColorActive(guiActive)
      .setLabel("rules\n+1")
      .plugTo(this, "incRules")
      ;
    cp5.getController("incRules").getCaptionLabel().align(ControlP5.CENTER, CENTER);

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
    cp5.getController("setRules").getCaptionLabel().align(ControlP5.CENTER, BOTTOM);

    cp5.addButton("randomizeRules")
      .setPosition(grid(5), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("RAND\nRULES")
      .plugTo(this, "randomizeRules")
      ;
    cp5.getController("randomizeRules").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    cp5.addButton("randomizeState")
      .setPosition(grid(6), grid(4))
      .setSize(guiObjectSize, guiObjectSize)
      .setColorForeground(guiForeground)
      .setColorBackground(guiBackground) 
      .setColorActive(guiActive)
      .setLabel("RAND\nSTATE")
      .plugTo(this, "randomizeStates")
      ;
    cp5.getController("randomizeState").getCaptionLabel().align(ControlP5.CENTER, CENTER);

    randomizeGradient();
  }

  public void draw() {
    background(backgroundColor);

    //render the gradient
    int start = grid(0);
    int end = grid(11)-guiBufferSize;
    for (int i = start; i < end; i++) {
      stroke(gradient.getColor((i-start)/float(end-start)));
      line(i, grid(2), i, grid(3)-guiBufferSize);
    }

    //render the neighborhood origin as a bounding box
    if ( neighborhood != null) {
      Toggle t = neighborhood.matrix[neighborhood.origin_c][neighborhood.origin_r];
      noFill();
      stroke(255);
      rect(t.getPosition()[0]-1, t.getPosition()[1]-1, t.getWidth()+1, t.getHeight()+1);
    }
    parent.redraw();
  }


  public void saveImage() {
    cp5.getController("run").setValue(0.0);
    save_file();
  }

  public void recordSequence(boolean _theValue) {
    record_sequence(_theValue);
  }
  
  public void typeStatesW(String _value) {
    cp5.getController("setStatesW").setValue(parseInt(_value));
  }

  public void typeStatesH(String _value) {
     cp5.getController("setStatesH").setValue(parseInt(_value));
  }

  public void setStatesW(int _value) {
    states_w = _value;
  }

  public void setStatesH(int _value) {
    states_h = _value;
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
    resizeStates();
    resizeCanvas();
  }

  // Neighborhood Kernel

  public void updateKernelGUI() {
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

  public void kernelAddRow() {
    neighborhood.addRow();
    this.updateKernelGUI();
  }
  public void kernelRemoveRow() {
    neighborhood.removeRow();
    this.updateKernelGUI();
  }
  public void kernelAddColumn() {
    neighborhood.addColumn();
    this.updateKernelGUI();
  }
  public void kernelRemoveColumn() {
    neighborhood.removeColumn();
    this.updateKernelGUI();
  }
  public void kernelIncOriginC() {
    neighborhood.incOriginC();
    this.updateKernelGUI();
  }
  public void kernelDecOriginC() {
    neighborhood.decOriginC();
    this.updateKernelGUI();
  }
  public void kernelIncOriginR() {
    neighborhood.incOriginR();
    this.updateKernelGUI();
  }
  public void kernelDecOriginR() {
    neighborhood.decOriginR();
    this.updateKernelGUI();
  }
  public void randomizeKernel() {
    neighborhood.randomize();
    this.updateKernelGUI();
  }
  public void randomizeKernelMatrix() {
    neighborhood.randomizeMatrix();
    this.updateKernelGUI();
  }
  public void randomizeKernelOrigin() {
    neighborhood.randomizeOrigin();
    this.updateKernelGUI();
  }


  // Gradient

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
        int index = parseInt(split(name, '_')[1]);
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

  // RULES

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

  public void runToggle(float _value) {
    run = _value > 0.0 ? true:false;
  }

  public void randomizeStates() {
    cca.randomStates(thresholds.size());
  }

  public void setThreshold(float _value) {
    cca.threshold=_value;
  }
}


public int grid( int _pos) {
  return gridSize * _pos + gridOffset;
}
