/*
CCA Playground
 by Phillip David Stearns 2021
 
 This is a bit of a mess. Sorry about that. I'm still fumbling my way around ControlP5.
 
 Cyclical Cellular Automata (CCA) are explained here: https://en.wikipedia.org/wiki/Cyclic_cellular_automaton
 
 Some of the terminology is mixed up in this here code:
 
 Neighborhood and neighbors are also decribed as Kernels here.
 Rules and Thresholds are used interconfusingly.
 CCA and States are a bit conflated too.
 
 Basically, imagine a system of M number of states 0 through M-1 and a 2D grid containing them.
 This grid starts out randomized. Each state, n, in this grid is evaluated based on the state of its neighbors.
 If the number of neighbors whose state is n+1 % M is greater than a pre-defined threshold,
 then the state assumes the value n+1 % M. For each state, a different threshold can be set for each state,
 these are what are called "rules" in the CCA Playground. The neighbors are defined by a neighborhood "Kernel"
 which can have 1-9 rows and 1-9 columns, and where neighbors can be counted or ignored.
 
 Classes at a glance:
 State - is the basic CCA engine and holds all the states and evaluation code
 Kernel - is the core of the neighborhood editor
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
int states_w = 512;
int states_h = 512;
int qty_states = 7;
int qty_colors = 3;
int zoom = 1;
int tempZoom = 0;

boolean run;
boolean record;
int sequenceIndex = 0;

States cca; // the cca core
Kernel neighborhood; // defines the neighborhood and which neighbors to count
Gradient gradient; // creates awesome colors and allows for some control
Palette palette; // pulls colors from the gradient and the number of rules
ControlFrame GUI; // holds all the fun buttons and sliders and things
ArrayList<Numberbox> thresholds; // holds the rule GUIs
RadioButton gradientColors; // a dynamic part of the gradient editor
ColorWheel gradientPicker; // temp use for selecting colors when editing the gradient

void settings() {
  size(10, 10);
  neighborhood = new Kernel();
  resizeStates();
  palette = new Palette("CCA Palette");
  thresholds = new ArrayList<Numberbox>();
  gradient = new Gradient();
  GUI = new ControlFrame(this, controlFrame_x, controlFrame_y, controlFrame_w, controlFrame_h);
}

void setup() {
  resizeCanvas();  
  surface.setLocation(screen_x, screen_y);
  background(palette.getSwatch(0).getColor());
}

void draw() {
  if (run) {   
    cca.evaluate(neighborhood.getKernelValues(), neighborhood.getOrigin(), getThresholds());
    image(cca.render(palette), 0, 0);
    if (record) {
      save(sequencePath+"/CCA_"+nf(sequenceIndex, 4)+".png");
      sequenceIndex++;
    }
  }
}

void resizeCanvas() {
  surface.setSize(states_w*zoom, states_h*zoom);
}

void resizeStates() {
  cca = new States(states_w, states_h);
}

int[] getThresholds() {
  int[] theThresholds= new int[thresholds.size()];
  for (int i = 0; i < theThresholds.length; i++) {
    theThresholds[i] = int(thresholds.get(i).getValue());
  }
  return theThresholds;
}
