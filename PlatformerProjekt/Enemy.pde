class Enemy extends GameObject {
  PImage enemySprites,enemy;
  int rot = 1;//den vej fjenden bevæger sig
  Enemy(PVector pos, PVector vel, float wIn, float hIn) {
    super(pos,vel,wIn,hIn);
    enemySprites = loadImage("data/textures/enemy.png");
    enemy = enemySprites.get(0, 0, 0, 0);
  }
  
  void update() {
    super.update();
    /*
    To punkter placeres udfra fjenden. Det ene punkt er 30 pixels mod højre og
    det andet punkt er 30 pixels mod venstre. Begge er placeret under fjenden.
    Dette er for at finde ud af om fjenden er på kanten af en platform hvilket
    ville betyde at den skal vende sig om for ikke at falde af. rot er hvilken
    vej spilleren er vendt. true = venstre, false = højre.
    */
    boolean left = false,right = false;
    position.add(-30,60);
    for(Platform p : game.platforms) {
      if(checkCollision(p.position,p.w,p.h)) {
        left = true;
      }
    }
    position.add(60,0);
    for(Platform p : game.platforms) {
      if(checkCollision(p.position,p.w,p.h)) {
        right = true;
      }
    }
    position.add(-30,-60);
    if(!left && right || !right && left) {
      rot *= -1;
    }
    position.x+=3*rot;
    for(Platform p : game.platforms) {
      if(checkCollision(p.position,p.w,p.h)) {
        rot *= -1;
      }
    }
  }
  
  void draw() {
    enemy = enemySprites.get(44*(Math.round(frame/2)%13), 0, 44, 66);
    imageMode(CENTER);
    pushMatrix();
    scale(rot,1);
    image(enemy,(position.x+10)*rot,position.y+15,w+15,h+15);
    popMatrix();
    imageMode(CORNER);
  }

}
