
public static float tileTimer;

public class Tile {
  int x, y;
  int solid;
  color color_;
  boolean walked;
  boolean deadEnd;
  boolean painted;

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
    if (!painted || ((Pathfinder)pathfinder).noPathFound || ((Pathfinder)pathfinder).stopped) {
      if (solid != 1 && (walked || deadEnd)) {
        color col = color(128);
        if (((Pathfinder) pathfinder).stopped || ((Pathfinder) pathfinder).noPathFound) {
          if (((Pathfinder) pathfinder).stopped)
            tileTimer = millis();
          if (tileTimer + 5100 > millis())
            col = color(0, 255 - random(0, 150), 0);
          else
            col = color(random(0, 255), random(0, 255), random(0, 255));
        }
        noStroke();
        fill(color_);
        if (walked)
          fill(255, 105, 180);
        if (deadEnd && walked) {
          fill(col);
          painted = true;
        }
        rect(x * tileSize, y * tileSize, tileSize, tileSize);
      }
    }
  }
}