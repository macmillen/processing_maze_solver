import ddf.minim.*;

// TODO: music during solve process
// TODO: select maze to solve in main menu

int counter = 0;

Minim minim;
AudioPlayer player;
AudioPlayer player2;

int cols;
int rows;
int fieldSize;
int tileSize;

ArrayList<Tile> tiles;

Thread pathfinder;
PImage maze;
PImage mazeResult;
Finish finish;
HScrollbar scrollbar;
Button btnRestart;
boolean restart = false;
int verticalMaximum = 800;
int mazeHeight;

synchronized void setup() {
  background(0);
  minim = new Minim (this); //<>//
  player = minim.loadFile ("music_1.mp3");
  player2 = minim.loadFile ("music_2.mp3");
  maze = loadImage("maze_07.png");
  mazeHeight = closestToVerticalMaximum(maze.height);
  tiles = new ArrayList<Tile>();
  cols = maze.width;
  rows = maze.height;
  fieldSize = cols * rows;
  tileSize = mazeHeight / rows;

  surface.setSize(cols * tileSize, rows * tileSize + 40);
  scrollbar = new HScrollbar(width / 2 - width / 4, height - 30, width / 2, 16, 3);
  btnRestart = new Button(width - 0, 50, 80, true);
  finish = new Finish(false);
  generateTiles();
  int newWidth = maze.width * rows * tileSize / maze.height;
  int newHeight = rows * tileSize;
  maze = resize(resizePixels(maze.pixels, maze.width, maze.height, newWidth,newHeight), newWidth,newHeight);
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
  ++counter;
  //clear();
  noStroke();
  println(frameRate);
  if(counter == 1 || ((Pathfinder)pathfinder).noPathFound || ((Pathfinder)pathfinder).stopped)
    image(maze,0,0);
  for (Tile t : tiles) {
    //TODO after maze was solved, create new image with the maze result (performance)
    /*
    if(((Pathfinder)pathfinder).stopped || ((Pathfinder)pathfinder).noPathFound) {
      mazeResult = createImage(cols, rows, RGB);
      mazeResult.loadPixels();
      for (int i = 0; i < mazeResult.pixels.length; i++) {
        mazeResult.pixels[i] = pixels_[i];
      }
      mazeResult.updatePixels();
    }
    */
    t.draw();
  }
  if (((Pathfinder)pathfinder).stopped || ((Pathfinder)pathfinder).noPathFound){
    finish.draw();
  }
  fill(255);
  rect(0,height - 40,width, 40);
  scrollbar.update();
  scrollbar.display();
  
  fill(0);
  textAlign(CENTER);
  textSize(17);
  text("speed", width / 2, height - 6);
  
  textAlign(LEFT);
  text("++",width / 5, height -25);
  textAlign(RIGHT);
  text("--",width - width / 5, height -25);
  
  // btnRestart.draw();
  
}

void mousePressed(){
  if(btnRestart.rectOver) {
    init();
  } //<>//
}

void changePixels(color before, color after) {
  for(int i = 0; i < maze.pixels.length; ++i)
    if(maze.pixels[i] == before)
      maze.pixels[i] = after;
}

PImage resize(int[] pixels_, int w, int h) {
  PImage img = createImage(w, h, RGB);
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = pixels_[i];
  }
  img.updatePixels();
  return img;
}

public int[] resizePixels(int[] pixels,int w1,int h1,int w2,int h2) {
    int[] temp = new int[w2*h2] ;
    // EDIT: added +1 to account for an early rounding problem
    int x_ratio = (int)((w1<<16)/w2) +1;
    int y_ratio = (int)((h1<<16)/h2) +1;
    //int x_ratio = (int)((w1<<16)/w2) ;
    //int y_ratio = (int)((h1<<16)/h2) ;
    int x2, y2 ;
    for (int i=0;i<h2;i++) {
        for (int j=0;j<w2;j++) {
            x2 = ((j*x_ratio)>>16) ;
            y2 = ((i*y_ratio)>>16) ;
            temp[(i*w2)+j] = pixels[(y2*w1)+x2] ;
        }                
    }                
    return temp ;
}

int closestToVerticalMaximum(int height_){
  int multiplied = 1;
  while(multiplied * height_ < verticalMaximum) {
    ++multiplied;
  }
  return (multiplied - 1) * height_;
}