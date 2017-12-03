public class Tile {

  int x, y;
  int solid;
  color color_;
  boolean walked;
  boolean deadEnd;

  Tile(int x, int y, int solid) {
    this.x = x;
    this.y = y;
    if (abs(solid) < 1800000) {
      this.color_ = color(255);
      this.solid = 0;
    } else {
      this.color_ = color(0);
      this.solid = 1;
    }
  }

  void draw() {
    color col = color(128);
    if(((Pathfinder) pathfinder).stopped) {
      col = color(0, 255 - random(0, 50), 0);
    }
    noStroke();
    fill(color_);
    if (walked)
      fill(255, 105, 180);
    if (deadEnd && walked)
      fill(col);
    rect(x * tileSize, y * tileSize, tileSize, tileSize);
  }
}