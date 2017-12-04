class Finish {

  int maxWords = 50;
  
  boolean noPathFound;

  String[] words = loadStrings("words.txt");
  ArrayList<Word> popUps = new ArrayList<Word>();

  Finish(boolean noPathFound) {
    this.noPathFound = noPathFound;
    if(noPathFound) maxWords = 400;
    for (int i = 0; i < maxWords; ++i) {
      if(noPathFound)
        popUps.add(new Word(words[(int) random(0, words.length)], 40, height + 50 * i));
      else
        popUps.add(new Word(words[(int) random(0, words.length)], (int) random(0, 30)));
    }
  }

  void draw() {
    for (Word popUp : popUps) {
      if(!noPathFound) {
        popUp.size += 0.7;
        popUp.draw();
        if (popUp.size > random(50, 100)) {
          popUp.size = 1;
          popUp.x = random(0, width);
          popUp.y = random(0, height);
        }
      }
      else {
        if(popUp.y > -100) {
          popUp.draw();
          popUp.y -= 8;
        }
      }
    }
    noStroke();
  }
}

class Word {
  float size;
  String string;
  float x, y;
  color col;

  Word(String string, float size) {
    this.string = string;
    this.size = size;
    x = random(0, width);
    y = random(0, height);
    col = color(random(0, 255), random(0, 255), random(0, 255));
  }
  
  Word(String string, float size, float y) {
    this.string = string;
    this.size = size;
    x = width / 2;
    this.y = y;
    col = color(255);
  }

  void draw() {
    fill(col);
    textSize(size);
    textAlign(CENTER);
    text(string, x, y);
  }
}