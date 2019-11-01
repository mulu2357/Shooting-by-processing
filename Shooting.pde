Control ctl;
EnemyControl eneCtl;
Background bg;
Player player;
ArrayList<Bullet> bullets;
ArrayList<Beam> beams;
ArrayList<Enemy> enemys;
ArrayList<Fall> falls;

boolean up, down, left, right;


boolean pause = true;

float t_start = 0;

int score;
int high_score;

PFont hand;
PFont def;
void setup() {
  size(1200, 800);
  frameRate(60);
  colorMode(HSB, 360, 100, 100);
  blendMode(SCREEN);
  rectMode(CENTER);

  hand = loadFont("/data/BradleyHandITC-32.vlw");
  def = loadFont("./data/ProcessingSansPro-Regular-32.vlw");
  
  bg = new Background();
  player = new Player();
  bullets = new ArrayList<Bullet>();
  beams = new ArrayList<Beam>();
  enemys = new ArrayList<Enemy>();
  falls = new ArrayList<Fall>();
  ctl = new Control();
  eneCtl = new EnemyControl();
  score = 0;
  
  high_score = int(loadStrings("./data/highscore.txt")[0]);
  
}

void reset(){
  bullets.removeAll(bullets);
  beams.removeAll(beams);
  enemys.removeAll(enemys);
  falls.removeAll(falls);
  bullets.clear();
  beams.clear();  
  enemys.clear();
  falls.clear();
  
  //player = new Player();
  //bullets = new ArrayList<Bullet>();
  //beams = new ArrayList<Beam>();
  //enemys = new ArrayList<Enemy>();
  //falls = new ArrayList<Fall>();
  //ctl = new Control();
  //eneCtl = new EnemyControl();
}

void draw() {
  ctl.state_transition();
   //<>//
  if (beams.size()>0) {
    Beam beam = beams.get(0);
    float per = 1-beam.cnt_frame/beam.LAST_FRAME;
    translate(random(-10*per, 10*per), random(-10*per, 10*per));
  }
  translate(width/2-player.pos.x,height/2-player.pos.y);
  
  
  ctl.run();

}

void score_plus(int n){
  score += n;
}

void pauseOn(){
  pause = true;
}

void pauseOff(){
  pause = false;
}

float getMouseX(){
  return mouseX+(int)player.pos.x-width/2;
}

float getMouseY(){
  return mouseY+(int)player.pos.y-height/2;
}

void keyPressed() {

  switch(key) {
  case 'w': 
    up = true; 
    break;
  case 's': 
    down = true; 
    break;
  case 'a': 
    left = true; 
    break;
  case 'd': 
    right = true; 
    break;
  }
}

void keyReleased() {
  switch(key) {
  case 'w': 
    up = false;
    break;
  case 's': 
    down = false;
    break;
  case 'a': 
    left = false;
    break;
  case 'd': 
    right = false;
    break;
  }
}

void draw_polygon(float x, float y, float r, int n) {    
  beginShape();
  for (int i=0; i<n; i++) {
    vertex(x+r/2*cos(i*2*PI/n), y+r/2*sin(i*2*PI/n));
  }
  endShape(CLOSE);
}
