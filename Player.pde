class Player {
  PVector pos;
  PVector vel;
  float rot;
  
  final float DEFALT_SPEED=10;
  float speed = DEFALT_SPEED;
  
  int size = 30;
  
  Player(){
    pos = new PVector();
    vel = new PVector();
    rot = random(2*PI);
    pos.x = width/2;
    pos.y = height/2;
  }
  
  private void move(){    
    if(up){
      vel.y = -speed;
    }
    
    if(down){
      vel.y = speed;
    }
    
    if(left){
      vel.x = -speed;
    }
    
    if(right){
      vel.x = speed;
    }
    
    if(pos.x+vel.x < 0 || pos.x+vel.x > width){
      vel.x=0;
    }
    if(pos.y+vel.y < 0 || pos.y+vel.y > height){
      vel.y=0;
    }
    
    vel.limit(speed);
    
    vel.mult(0.8);
    pos.add(vel);
    rot += map(vel.mag(),0,speed,1,5)*PI/90;
  }
  
  private void show(){
    noStroke();
    fill(frameCount%360,20,100,30);
    ellipse(pos.x,pos.y,size*5,size*5);
    
    stroke(frameCount%360,70,100);
    fill(frameCount%360,70,80);
    ellipse(pos.x,pos.y,size,size);
    
    stroke(frameCount%360,70,70);
    fill(frameCount%360,70,30);
    push();
    translate(pos.x,pos.y);
    rotate(rot);
    for(int i=0;i<3;i++){
      ellipse(2*size*cos(i*2*PI/3),2*size*sin(i*2*PI/3),size/2,size/2);
    }
    pop();
    fill(frameCount%360,20,100,30);
    arc(pos.x,pos.y,size*3,size*3,-PI/2,map(ctl.beam_charge_frame_cnt,0,ctl.MAX_BEAM_CHARGE_FRAME,-PI/2,4*PI-PI/2));
    if(ctl.beam_charge_frame_cnt > ctl.MAX_BEAM_CHARGE_FRAME/2){
      arc(pos.x,pos.y,size*3,size*3,-PI/2,map(ctl.beam_charge_frame_cnt,ctl.MAX_BEAM_CHARGE_FRAME/2,ctl.MAX_BEAM_CHARGE_FRAME,-PI/2,2*PI-PI/2));
    }
  }
  
  void run(){
    move();
    show();
  }
}
