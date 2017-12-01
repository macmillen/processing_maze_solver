class Finish {

  final int maxWords = 50;

  String[] words = loadStrings("words.txt");
  ArrayList<Word> popUps = new ArrayList<Word>();

  Finish() {
    for (int i = 0; i < maxWords; ++i) {
      popUps.add(new Word(words[(int) random(0, words.length)], (int) random(0, 30)));
    }
  }

  void draw() {
    for (Word popUp : popUps) {
      popUp.size += 0.7;
      popUp.draw();
      if(popUp.size > random(50, 100)){
        popUp.size = 1;
        popUp.x = random(0, width);
        popUp.y = random(0,height);
      }
    }
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
    col = color(random(0,255),random(0,255),random(0,255));
  }

  void draw() {
    fill(col);
    textSize(size);
    textAlign(CENTER);
    text(string, x, y);
  }
}