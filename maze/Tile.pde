public class Tile{
  
  int x, y;
  final static int size = 20;
  int solid;
  color color_;
  boolean walked;
  boolean deadEnd;
  
  Tile(int x, int y, int solid){
    this.x = x;
    this.y = y;
    if(abs(solid) < 1800000) {
      this.color_ = color(255);
      this.solid = 0;
    }
    else{
      this.color_ = color(0);
      this.solid = 1;
    }
  }

  void draw(){
    fill(color_);
    if(walked)
      fill(255,105,180);
    if(deadEnd && walked)
      fill(128);
    rect(x * size, y * size, size, size);
  }
}