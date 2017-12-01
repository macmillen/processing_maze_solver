class Pathfinder extends Thread { 

  ArrayList<PVector> lastTiles = new ArrayList<PVector>();
  Tile firstTile;
  Tile currentTile;
  long speed = 7;
  boolean stopped;

  final int[][] DIRECTIONS = {{0, -1}, {1, 0}, {0, 1}, {-1, 0}}; // N, E, S, W

  void run() {  
    findFirstTile();
    currentTile = new Tile(firstTile.x, firstTile.y, 0);
    check(currentTile);
  }

  void findFirstTile() {
    for (int i = 0; i < rows; ++i) {
      if (tiles.get(i * rows).solid == 0) {
        firstTile = new Tile(tiles.get(i * rows).x, tiles.get(i * rows).y, 0);
        tiles.get(i * rows).walked = true;
        return;
      }
    }
  }
  
  void check(Tile currentTile) {
    
    for (int i = 0; i < DIRECTIONS.length; ++i) {
      if(stopped)
        return;
      int pos = newPos(currentTile, (int) DIRECTIONS[i][0], (int) DIRECTIONS[i][1]);
      if (tileIsWalkable(pos)) {
        try{
          sleep(speed);
        }
        catch(InterruptedException e){
          
        }
        tiles.get(pos).walked = true;
        Tile newCurrentTile = new Tile(currentTile.x + DIRECTIONS[i][0], currentTile.y + DIRECTIONS[i][1], 0);
        if(newCurrentTile.x == cols - 1) {
          stopped = true;
          finish = new Finish();
          player.play();
          return;
        }
        check(newCurrentTile);
        if(i == 3 && tiles.get(pos).solid == 0 && stopped) return;
      }
    }
    tiles.get(newPos(currentTile,0,0)).deadEnd = true;
  }
  int newPos(Tile currentTile, int xOffset, int yOffset) {
    return (int) (currentTile.x + xOffset + (currentTile.y + yOffset) * rows);
  }
  boolean tileIsWalkable(int pos) {
    if (tiles.get(pos).solid == 0 && !tiles.get(pos).walked)
      return true;
    else
      return false;
  }
}