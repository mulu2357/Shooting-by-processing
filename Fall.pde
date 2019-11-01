class Fall { // Effect
  PVector pos[];
  PVector vel[];
  float rot[];
  
  int NUM;
  float speed;
  float size;
  int poly;
  color col;
  
  float cnt_frame;
  float LAST_FRAME=60;
  
  Fall(float x,float y,int n,color c){
    NUM=5;
    pos = new PVector[NUM];
    vel = new PVector[NUM];
    rot = new float[NUM];
    col = c;
    speed = 30;
    size = 60;
    poly = n;
    cnt_frame=0;
    
    for(int i=0;i<NUM;i++){
      pos[i] = new PVector(x,y);
      float theta = random(2*PI);
      vel[i] = new PVector(speed*cos(theta),speed*sin(theta));
      rot[i] = random(2*PI);
    }
  }
  
  private void move(){
    for(int i=0;i<NUM;i++){
      vel[i].mult(0.8);
      pos[i].add(vel[i]);
      rot[i] += vel[i].mag()*PI/45;
    }
    cnt_frame++;
  }
  
  private void show(){
    for(int i=0;i<NUM;i++){
      stroke(col,100*(1-cnt_frame/LAST_FRAME));
      fill(col,80*(1-cnt_frame/LAST_FRAME));
      push();
      translate(pos[i].x,pos[i].y);
      rotate(rot[i]);
      draw_polygon(0,0,size,poly);
      pop();
    }
  }
  
  void run(){
    move();
    show();
  }
  
  boolean isFrameEnd(){
    boolean ans=false;
    if(cnt_frame>LAST_FRAME) ans = true;
    return ans;
  }
}
