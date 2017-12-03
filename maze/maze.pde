import ddf.minim.*;

Minim minim;
AudioPlayer player;

int cols;
int rows;
int fieldSize;
float tileSize;

ArrayList<Tile> tiles;

Thread pathfinder;
PImage maze;
Finish finish;
HScrollbar scrollbar;
Button btnRestart;
boolean restart = false;

synchronized void setup() {
  background(0);
  minim = new Minim (this); //<>//
  player = minim.loadFile ("music.mp3");
  maze = loadImage("maze_11.png");
  tiles = new ArrayList<Tile>();
  cols = maze.width;
  rows = maze.height;
  fieldSize = cols * rows;
  tileSize = 700.0 / rows;

  surface.setSize(int(cols * tileSize) + 100, int(rows * tileSize) + 20);
  scrollbar = new HScrollbar(width / 2 - width / 4, height - 12, width / 2, 16, 3);
  btnRestart = new Button(width - 0, 50, 80, true);
  finish = new Finish();
  generateTiles();
  pathfinder = new Pathfinder();
  pathfinder.start();
}

void generateTiles(){
  for (int i = 0; i < fieldSize; ++i) {
    tiles.add(new Tile(i % cols, i / cols, maze.get(i % cols, i / cols) + 1));
  }
}

synchronized void init(){
  tiles.clear();
  generateTiles();
  ((Pathfinder)pathfinder).init();
}

void draw() {
  //clear();
  noStroke();
  for (Tile t : tiles) {
    t.draw();
  }
  if (((Pathfinder)pathfinder).stopped){
    finish.draw();
    
  }
  scrollbar.update();
  scrollbar.display();
  btnRestart.draw();
  
}

void mousePressed(){
  if(btnRestart.rectOver) {
    init();
  } //<>//
}