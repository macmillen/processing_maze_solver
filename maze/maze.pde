import ddf.minim.*;

Minim minim;
AudioPlayer player;

 int cols;
 int rows;
 int fieldSize;

ArrayList<Tile> tiles = new ArrayList<Tile>();

Thread pathfinder;

Finish finish;

void setup(){
  minim = new Minim (this);
  player = minim.loadFile ("music.mp3");
  PImage maze = loadImage("maze_2.png");
  cols = maze.width;
  rows = maze.height;
  fieldSize = cols * rows;
  
  noStroke();
  surface.setSize(cols * Tile.size, rows * Tile.size);
  
  for(int i = 0; i < cols * rows; ++i){
    tiles.add(new Tile(i % cols, i / rows, maze.get(i % cols, i / rows) + 1));
  }
  pathfinder = new Pathfinder();
  pathfinder.start();
}

void draw(){
  for(int i = 0; i < fieldSize; ++i){
    tiles.get(i).draw();
  }
  if(finish != null)
    finish.draw();
}