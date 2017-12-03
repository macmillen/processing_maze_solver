
class Button {
  float rectX, rectY;      // Position of square button
  float circleX, circleY;  // Position of circle button
  int rectSize = 90;     // Diameter of rect
  int circleSize = 93;   // Diameter of circle
  color rectColor, circleColor, baseColor;
  color rectHighlight, circleHighlight;
  color currentColor;
  boolean rectOver = false;
  boolean circleOver = false;
  boolean rect;

  Button(float x, float y, int size, boolean rect) {
    this.rect = rect;
    rectSize = size;
    circleSize = size;
    rectColor = color(0);
    rectHighlight = color(51);
    circleColor = color(255);
    circleHighlight = color(204);
    baseColor = color(102);
    currentColor = baseColor;
    circleX = x+circleSize/2+10;
    circleY = y;
    rectX = x-rectSize-10;
    rectY = y-rectSize/2;
    ellipseMode(CENTER);
  }

  void draw() {
    update(mouseX, mouseY);

    if (rectOver) {
      fill(rectHighlight);
    } else {
      fill(rectColor);
    }
    stroke(255);
    if(rect)
      rect(rectX, rectY, rectSize, rectSize);

    if (circleOver) {
      fill(circleHighlight);
    } else {
      fill(circleColor);
    }
    stroke(0);
    if(!rect)
      ellipse(circleX, circleY, circleSize, circleSize);
  }

  void update(int x, int y) {
    if ( overCircle(circleX, circleY, circleSize) ) {
      circleOver = true;
      rectOver = false;
    } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
      rectOver = true;
      circleOver = false;
    } else {
      circleOver = rectOver = false;
    }
  }

  void mousePressed() {
    if (circleOver) {
      currentColor = circleColor;
    }
    if (rectOver) {
      currentColor = rectColor;
    }
  }

  boolean overRect(float x, float y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }

  boolean overCircle(float x, float y, int diameter) {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
      return true;
    } else {
      return false;
    }
  }
}