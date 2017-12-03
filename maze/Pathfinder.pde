class Pathfinder extends Thread { 
  Tile firstTile;
  Tile currentTile;
  public long speed = 5;
  boolean stopped;

  final int[][] DIRECTIONS = {{0, -1}, {1, 0}, {0, 1}, {-1, 0}}; // N, E, S, W

  void run() {  
    init();
    check(currentTile);
    stopped = true;
  }
  
  synchronized void init(){
    findFirstTile();
    currentTile = new Tile(firstTile.x, firstTile.y, 0);
  }

  synchronized void findFirstTile() {
    for (int i = 0; i < rows; ++i) {
      if (tiles.get(i * cols).solid == 0) {
        firstTile = new Tile(tiles.get(i * cols).x, tiles.get(i * cols).y, 0);
        tiles.get(i * cols).walked = true;
        return;
      }
    }
  }

  void check(Tile currentTile) {
    speed = (long) scrollbar.getPos();
    for (int i = 0; i < DIRECTIONS.length; ++i) {
      if (stopped)
        return; //<>//
      int pos = newPos(currentTile, (int) DIRECTIONS[i][0], (int) DIRECTIONS[i][1]);
      if (tileIsWalkable(pos)) {
        try {
          sleep(speed);
        }
        catch(InterruptedException e) {
        }
        tiles.get(pos).walked = true;
        Tile newCurrentTile = new Tile(currentTile.x + DIRECTIONS[i][0], currentTile.y + DIRECTIONS[i][1], 0);
        if (newCurrentTile.x == cols - 1) {
          stopped = true;
          player.play();
          return;
        }
        check(newCurrentTile);
        if (i == 3 && tiles.get(pos).solid == 0 && stopped) return;
      }
    }
    tiles.get(newPos(currentTile, 0, 0)).deadEnd = true;
    try{
      sleep(speed);
    }catch(Exception e){}
  }
  int newPos(Tile currentTile, int xOffset, int yOffset) {
    return (int) (currentTile.x + xOffset + (currentTile.y + yOffset) * cols);
  }
  boolean tileIsWalkable(int pos) {
    if (tiles.get(pos).solid == 0 && !tiles.get(pos).walked)
      return true;
    else
      return false;
  }
}