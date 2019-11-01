class Control {
  int beam_charge_frame_cnt;
  int MAX_BEAM_CHARGE_FRAME = 120;
  float TIME_LIMIT = 60;

  Control() {
  }

  void state_transition() {
    if (keyPressed && key == 'z' && pause) {
      pauseOff();
      score = 0;
      t_start = millis();
    }

    if (millis()-t_start >= TIME_LIMIT*1000) {
      //t_start = millis();
      reset();
      pauseOn();
      if(score > high_score){
        high_score = score;
        String[] lines = new String[1];
        lines[0] = str(high_score);
        saveStrings("./data/highscore.txt",lines);
      }
    }
  } 

  void bullet_mane() {   
    if (beam_charge_frame_cnt > 0 && mousePressed==false) {
      if (beam_charge_frame_cnt < MAX_BEAM_CHARGE_FRAME/2) {
        beams.add(new Beam(player.pos.x, player.pos.y, getMouseX()-player.pos.x, getMouseY()-player.pos.y, 0));
      } else if (beam_charge_frame_cnt < MAX_BEAM_CHARGE_FRAME) {
        beams.add(new Beam(player.pos.x, player.pos.y, getMouseX()-player.pos.x, getMouseY()-player.pos.y, 1));
      } else {
        beams.add(new Beam(player.pos.x, player.pos.y, getMouseX()-player.pos.x, getMouseY()-player.pos.y, 2));
      }
      beam_charge_frame_cnt = 0;
    } else if (frameCount%6==0 && mousePressed == false) {
      PVector tvel = new PVector(getMouseX()-player.pos.x, getMouseY()-player.pos.y);
      bullets.add(new Bullet(player.pos.x, player.pos.y, tvel.x, tvel.y));
    } else if (mousePressed && beams.size()==0) {
      if (beam_charge_frame_cnt < MAX_BEAM_CHARGE_FRAME) {
        beam_charge_frame_cnt++;
      }
    }

    for (int i=0; i<bullets.size(); i++) {
      Bullet bullet = bullets.get(i);
      if (bullet.isOutside()) {
        bullets.remove(i);
      }
      bullet.run();
    }

    for (int i=0; i<beams.size(); i++) {
      Beam beam = beams.get(i);
      if (beam.isFrameEnd()) {
        beams.remove(i);
      }
      for (int j=0; j<enemys.size(); j++) {
        Enemy enemy = enemys.get(j);
        float dist = beam.PtoL_dist(enemy.pos.x, enemy.pos.y, beam.pos.x, beam.pos.y, beam.epos.x, beam.epos.y);
        println(enemys.size(), dist);
        if (dist != -1 && dist <= beam.wei/2+enemy.size/2) {
          falls.add(new Fall(enemy.pos.x, enemy.pos.y, enemy.poly, beam.col));
          score_plus(200);
          enemys.remove(j);
        }
      }
      beam.run();
    }
  }

  void enemy_mane() {
    if (!pause) eneCtl.enemy_gene();

    for (int i=0; i<enemys.size(); i++) {
      Enemy enemy = enemys.get(i);
      if (enemy.isDead()) {
        score_plus(100);
        enemys.remove(i);
      }
      enemy.run();
    }
  }

  void enemy_bullet_judge() {
    for (int i=0; i<bullets.size(); i++) {
      Bullet bullet = bullets.get(i);
      for (int j=0; j<enemys.size(); j++) {
        Enemy enemy = enemys.get(j);
        if (dist(bullet.pos.x, bullet.pos.y, enemy.pos.x, enemy.pos.y)<bullet.get_size()/2+enemy.get_size()/2) {
          enemy.life_dec();
          if (enemy.isDead()) {
            falls.add(new Fall(enemy.pos.x, enemy.pos.y, enemy.poly, bullet.c));
          }
          bullets.remove(i);
          break;
        }
      }
    }
  }

  void fall_mane() {
    for (int i=0; i<falls.size(); i++) {
      Fall fall = falls.get(i);
      fall.run();
      if (fall.isFrameEnd()) {
        falls.remove(i);
      }
    }
  }

  void run() {
    bg.run();
    player.run();
    bullet_mane();
    if(!pause){
      fall_mane();
      enemy_bullet_judge();
      enemy_mane();
    }
  }
}
