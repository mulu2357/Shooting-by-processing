class Background {

  Background() {
  }

  private void move() {
  }

  private void show() {
    background(0);

    textAlign(CENTER);
    textFont(def);
    noStroke();
    fill(360, 80*360/100);

    text("SCORE\n"+score, width-width/2, height/2);
    if (pause) {
      textFont(def);
      noStroke();
      fill(360, 80*360/100);
      text("HIGH SCORE\n"+high_score, width/2, height-height/4);

      textFont(hand);
      noStroke();
      fill(360);
      text("z push start", width/2, height/4);
    }
    if (!pause) {
      textFont(def);
      noStroke();
      fill(360, 80*360/100);
      text(60-(int)((millis()-t_start)/1000), width/2, height-height/4);
    }


    stroke(360);
    noFill();
    rect(width/2, height/2, width, height);
  }

  void run() {
    move();
    show();
  }
}
