class Enemy {
  PVector pos;
  PVector vel;
  float rot;
  
  float MAX_SIZE;
  float size = 0;
  
  float speed;
  int MAX_LIFE;
  int life;
  int poly;

  float start_f;

  Enemy(float x, float y, int type) {
    pos = new PVector(x, y);
    vel = new PVector();
    rot = random(2*PI);
    
    switch (type) {
    case 0:
      MAX_SIZE=30;
      MAX_LIFE = 3;
      speed = 1.5;
      poly = 5;
      break;    
    case 1:
      MAX_SIZE=50;
      MAX_LIFE = 7;
      speed = 1;
      poly = 7;
      break;
    case 2:
      MAX_SIZE = 30;
      MAX_LIFE = 1;
      speed = 5;
      poly = 3;
    }
    life = MAX_LIFE;
    
    start_f = random(180);
  }

  private void move() {
    if(MAX_SIZE>size){
      size++;
    }
    
    vel.x = player.pos.x-pos.x;
    vel.y = player.pos.y-pos.y;
    vel.setMag(speed);
    pos.add(vel);
    rot += speed*PI/90;
  }

  private void show() {
    noStroke();
    fill(360);
    //rect(pos.x, pos.y, size, size);
    push();
    translate(pos.x,pos.y);
    //rotate((frameCount-start_f)*PI/90);
    rotate(rot);
    draw_polygon(0,0,size,poly);
    stroke(360);
    noFill();
    draw_polygon(0,0,size*1.2,poly);
    pop();
  }
  
  void run() {
    move();
    show();
  }
  
  void life_dec(){
    life--;
  }
  
  boolean isDead(){
    boolean ans = false;
    if(life <= 0){
      ans = true;
    }
    return ans;
  }

  float get_size() {
    return size;
  }
}

class EnemyControl {
  int MAX_NUM = 1000;
  int SHOWABLE_NUM = 10;
  int rest = MAX_NUM;

  EnemyControl() {
    int i;
    //for (i=0; i<SHOWABLE_NUM; i++) {
    //  add_enemy();
    //}
  }

  void enemy_gene() {
    if (SHOWABLE_NUM > enemys.size() && rest>0) {
      add_enemy();
    }
  }

  private void add_enemy() {
    float x=0,y=0;
    if(player.pos.x < width/2 && player.pos.y < height/2){
      x = random(width/2,width);
      y = random(height/2,height);
    }
    else if(player.pos.x < width/2 && player.pos.y > height/2){
      x = random(width/2,width);
      y = random(height/2);
    }
    else if(player.pos.x > width/2 && player.pos.y < height/2){
      x = random(width/2);
      y = random(height/2,height);
    }
    else if(player.pos.x > width/2 && player.pos.y >= height/2){
      x = random(width/2,width);
      y = random(height/2);
    }
    else{
      x = random(width);
      y = random(height);
    }
    
    enemys.add(new Enemy(x, y, (int)random(3)));
    rest--;
  }
}
