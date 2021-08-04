/*
CCA Playground
 by Phillip David Stearns 2021
 
 This is a bit of a mess. Sorry about that. I'm still fumbling my way around ControlP5.
 
 Cyclical Cellular Automata (CCA) are explained here: https://en.wikipedia.org/wiki/Cyclic_cellular_automaton
 
Imagine a system comprising a 2D grid states. In this system there are a total of M finite states n0 through nM-1.
 This grid starts out randomized. Each state, nx, in this grid is evaluated based on the state of its neighbors.
 If the number of neighbors whose state is n+1 % M is greater than a pre-defined threshold,
 then the state, nx, assumes the value n+1 % M. For each state, a different threshold can be set,
 these are what are called "rules" in the CCA Playground. A neighborhood matrix specifies the size of the
 neighborhood, and which neighbors are to be counted or ignored.
 
 Classes at a glance:
 CCA - is the basic CCA engine and holds all the states and evaluation code
 Neighborhood - is the core of the neighborhood editor and defines which neighbors to count
 Gradient - allows for custom color palette creation
 Palette - is generated from the gradient
 
 That probably doesn't help much with understanding what's going on. I'll be working to clean things up
 and add more useful comments than the mush above.
 
 For now, feel free to mash buttons and report when things don't work or break.
 */

import controlP5.*;
import java.util.*;

// GUI size variables
int guiObjectSize = 40;
int guiObjectWidth = 600;
int guiBufferSize = 10;
int gridSize = guiObjectSize + guiBufferSize;
int gridOffset = guiBufferSize;

public int grid( int _pos) { // helper for positioning GUI elements
  return gridSize * _pos + gridOffset;
}

// GUI color variables
color backgroundColor = color(15);
color guiGroupBackground = color(30);
color guiBackground = color(60);
color guiForeground = color(120);
color guiValue = color(255);
color guiValueInactive = color(150, 50);
color guiGroupBackgroundInactive = color(30, 50);
color guiBackgroundInactive = color(50, 50);
color guiForegroundInactive = color(100, 50);
color guiActive=color(150);
color guiInactive=color(120, 50);
color guiOrigin=color(127);
//GUI display positioning and sizing
int controlFrame_w = grid(11);
int controlFrame_h = grid(16);
int controlFrame_x = 0;
int controlFrame_y = 0;
// Main graphic display positioning
int screen_x = controlFrame_w;
int screen_y = 0;
// Initial parameters for the size and scaling of the CCA
int cca_w = 512;
int cca_h = 512;
int qty_states = 7;
int qty_colors = 3;
int zoom = 1;
int tempZoom = 0;

boolean run;
boolean record;
int sequenceIndex = 0;

CCA cca; // the cca core
Neighborhood neighborhood; // defines the neighborhood and which neighbors to count
Gradient gradient; // creates awesome colors and allows for some control
Palette palette; // pulls colors from the gradient and the number of rules
ControlFrame GUI; // holds all the fun buttons and sliders and things
ArrayList<Numberbox> thresholds; // holds the rule GUIs
RadioButton gradientColors; // a dynamic part of the gradient editor
ColorWheel gradientPicker; // temp use for selecting colors when editing the gradient

void settings() {
  size(10, 10);
  thresholds = new ArrayList<Numberbox>();
  neighborhood = new Neighborhood();
  palette = new Palette("CCA Palette");
  gradient = new Gradient();
  resizeCCA();
  GUI = new ControlFrame(this, controlFrame_x, controlFrame_y, controlFrame_w, controlFrame_h);
}

void setup() {
  resizeCanvas();
  surface.setLocation(screen_x, screen_y);
  background(palette.getSwatch(0).getColor());
  cca.randomizeStates(thresholds.size());
}

void draw() {
  if (run) {   
    cca.evaluate(neighborhood.getNeighborhoodValues(), neighborhood.getOrigin(), getThresholds());
    image(cca.render(palette), 0, 0);
    if (record) {
      save(sequencePath+"/CCA_"+nf(sequenceIndex, 4)+".png");
      sequenceIndex++;
    }
  }
}

void resizeCanvas() {
  surface.setSize(cca_w*zoom, cca_h*zoom);
}

void resizeCCA() {
  cca = new CCA(cca_w, cca_h);
  cca.randomizeStates(thresholds.size());
}

int[] getThresholds() {
  int[] theThresholds= new int[thresholds.size()];
  for (int i = 0; i < theThresholds.length; i++) {
    theThresholds[i] = int(thresholds.get(i).getValue());
  }
  return theThresholds;
}
