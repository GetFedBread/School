class GameObject {
  PVector position;//objektets lokation
  PVector velocity;//hastighed som objektet bevæger sig med
  float w,h;//brede og højde
  int side,frame;//hvilken side et gameObject rammer. Frame går op 1 gang hver frame
  boolean locked;//hvis true er objektet ikke effekteret af bevægelseskrafter

  GameObject(PVector pos, PVector vel, float wIn, float hIn) {
    position = pos;
    velocity = vel;
    w = wIn;
    h = hIn;
  }

  void update() {
    frame++;
    position.add(velocity);
    if(!locked) {
      movement();
    }else if(game.lose && locked) {
      movement();
    }
  }
  
  void movement() {
    boolean check = false;
    for(Platform p : game.platforms) {
        if(p.checkCollision(position,w,h)) {
          /*
          Hvis spilleren er inden for en platform finder programmet den korteste
          rute ud fra platformen. Derefter tjekkes hvilken side af platformen som
          spilleren er i kontakt med.
          */
          position = p.uncollide(position,w,h);
          side = p.collisionSide(position,w,h);
          check = true;
        }
    }
    if(!check) {
      side = 0;
    }
    //friktion og luftmodstand
    velocity.x-=velocity.x/50;
    if(side == 3) {
      velocity.x-=velocity.x/5;
    }
    //simulerer tyngdekraften
    if(velocity.y<20) {
      if(side == 1 && velocity.y>4 || side == 2 && velocity.y>4) {
        velocity.y-=1;
      }else {
        velocity.y+=abs(velocity.y/20);
        velocity.y+=0.4;
      }
    }
    /*
    Sørger for at hastigheden ikke bygger op når man presser mod en platform.
    Dette er for at ungå at tyngdekraften bygger hastighed op.
    Bruges også til at finde ud af om spilleren er på en væg så de kan walljumpe. 
    */
    switch (side) {
      case 1:
      if(velocity.x>0) {
        velocity.x = 0;
      }
      break;
      case 2:
      if(velocity.x<0) {
        velocity.x = 0;
      }
      break;
      case 3:
      if(velocity.y>0) {
        velocity.y = 0;
      }
      break;
      case 4:
      if(velocity.y<0) {
        velocity.y = 0;
      }
      break;
    }
  }

  void draw() {
  }
  
  //finder ud af om to gameObjects er inden for hinanden.
  boolean checkCollision(PVector posIn, float wIn, float hIn) {
    return posIn.x+wIn>position.x && posIn.x<position.x+w && posIn.y+hIn>position.y && posIn.y<position.y+h;
  }
}
