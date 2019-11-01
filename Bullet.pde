class Bullet {
  PVector pos;
  PVector vel;

  float speed;
  float size;

  color c;

  Bullet(float px, float py, float vx, float vy) {
    this.pos = new PVector(px, py);
    this.vel = new PVector(vx, vy);

    speed = 10;
    this.vel.setMag(speed);

    size = 25;

    c = color(frameCount%360, 100, 100);
  }

  boolean isOutside() {
    boolean ans = false;
    if(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height){
      ans = true;
    }
    return ans;
  }

  private void move() {
    this.pos.add(this.vel);
  }

  private void show() {
    stroke(c);
    fill(c,80);
    ellipse(this.pos.x, this.pos.y, size, size);
  }

  void run() {
    move();
    show();
  }
  
  float get_size(){
    return size;
  }
}

class Beam {//effect
  PVector pos; // line from pos to epos
  PVector epos;
  float wei;
  final float LEN = sqrt(sq(width)+sq(height));
  float cnt_frame;
  float LAST_FRAME = 60;
  
  color col;
  
  Beam(float px, float py, float vx, float vy, int type){
    this.pos = new PVector(px, py);
    this.epos = new PVector(vx, vy);
    epos.setMag(LEN);
    epos.add(pos);
    
    col = color(frameCount%360,100,100);
    
    cnt_frame = 0;
    
    wei = 30 + type*60;
    //for(int i=0;i<enemys.size();i++){
    //  Enemy enemy = enemys.get(i);
    //  float dist = PtoL_dist(enemy.pos.x,enemy.pos.y,pos.x,pos.y,epos.x,epos.y);
    //  println(enemys.size(),dist);
    //  if(dist != -1 && dist <= wei/2+enemy.size/2){
    //    enemys.remove(i);
    //  }
    //}
  }
  
  float PtoL_dist(float px, float py, float x1, float y1, float x2, float y2){
    float tt = -((x2-x1)*(x1-px)+(y2-y1)*(y1-py));
    if(tt < 0 || tt>sq(x2-x1)+sq(y2-y1)){
      return -1;
    }
    return abs((y2-y1)*px-(x2-x1)*py+x2*y1-y2*x1)/sqrt(sq(y2-y1)+sq(x2-x1));
  }
  
  private void move(){
    
    cnt_frame++;
  }
  
  private void show(){
    strokeWeight(wei*abs(sin(map(cnt_frame,0,LAST_FRAME,0,PI))));
    //stroke(frameCount%360,100,100);
    stroke(col,95);
    line(pos.x,pos.y,epos.x,epos.y);
    strokeWeight(5*wei*abs(sin(map(cnt_frame,0,LAST_FRAME,0,PI))));
    //stroke(frameCount%360,20,100,15);
    stroke(col,15);
    line(pos.x,pos.y,epos.x,epos.y);
    strokeWeight(1);
  }
  
  void run(){
    move();
    show();
  }
  
  boolean isFrameEnd(){
    boolean ans = false;
    if(cnt_frame >= LAST_FRAME){
      ans = true;
    }
    return ans; 
  }
}
