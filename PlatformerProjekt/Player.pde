class Player extends GameObject {
  PImage playerSprites,player;//framewidth = 200, frameheight = 148
  boolean left,right,up;
  int score,health,rot = 1;
  
  Player(PVector pos, PVector vel, float wIn, float hIn) {
    super(pos, vel, wIn, hIn);
    health = 5;
    locked = false;
    playerSprites = loadImage("data/textures/player.png");
    player = playerSprites.get(0, 0, 0, 0);
  }
  
  void inputHandler(char tast, boolean p) {
    if(tast == ' ' || tast == 'w') {
      up = p;
    }
    if(tast == 'a') {
      left = p;
    }
    if(tast == 'd') {
      right = p;
    }
  }

  void update() {
    super.update(); // kalder først baseklassens update
    //Spillerens bevægelse
    if(up && side>0) {
      jump.play();
    }
    if(side == 3) {
      if(up) {
        velocity.y = -19;
      }
      if(left) {
        velocity.x-=1.5;
      }
      if(right) {
        velocity.x+=1.5;
      }
    }else {
      if(left) {
        velocity.x-=0.2;
      }
      if(right) {
        velocity.x+=0.2;
      }
      if(up) {
        if(side == 1 && right) {
          velocity.set(-10,-16);
        }
        if(side == 2 && left) {
          velocity.set(10,-16);
        }
      }
    }
    for(Coin c : game.coins) {
      if(checkCollision(c.position,20,20) && !c.collect) {
        score++;
        coin.play();
        c.collect = true;
      }
    }
    for(Enemy e : game.enemies) {
      if(checkCollision(e.position,30,40) && health>0) {
        health--;
        if(score>0) {
          score--;
        }
        if(health>0) {
          damage.play();
          game.loadLevel();
        }else {
          lose.play();
          game.lose = true;
        }
      }
    }
    if(position.y>width && health>0) {
      health--;
      if(score>0) {
          score--;
        }
      if(health>0) {
        damage.play();
        game.loadLevel();
      }else {
        lose.play();
        game.lose = true;
      }
    }
  }
  
  void draw() {
    boolean ground = false;
    position.add(0,1);
    for(Platform p : game.platforms) {
      if(checkCollision(p.position,p.w,p.h)) {
        ground = true;
      }
    }
    position.add(0,-1);
    if(right && !left) {
      rot = 1;
    }else if(left && !right) {
      rot = -1;
    }
    /*
    Alle de forskellige if-statements chekker hvilken frame/animation som spilleren
    skal fremstille. 
    */
    if(abs(velocity.x)<1 && ground) {
      player = playerSprites.get(200*(Math.round(frame/8)%4), 0, 200, 148);
    }else if(abs(velocity.x)>1 && ground) {
      player = playerSprites.get(200*(Math.round(frame/8)%6)+200, 148, 200, 148);
    }else if(side == 1 || side == 2) {
     player = playerSprites.get(200*(Math.round(frame/8)%4)+190, 148*4, 200, 148);
    }else if(velocity.y>20 && !ground) {
      player = playerSprites.get(200*(Math.round(frame/8)%2)+200, 148*3, 200, 148);
    }else if(velocity.y<3 && !ground) {
      player = playerSprites.get(800, 148, 200, 148);
    }else if(velocity.y<5 && !ground) {
      player = playerSprites.get(1000, 148, 200, 148);
    }
    if(abs(velocity.x)>1 && ground) {
      if(!footsteps.isPlaying()) {
        footsteps.play();
      }
    }else {
      if(footsteps.isPlaying()) {
        footsteps.stop();
      }
    }
    imageMode(CENTER);
    pushMatrix();
    scale(rot,1);
    image(player,(position.x+15)*rot,position.y+15,w+40,h+15);
    popMatrix();
    imageMode(CORNER);
  }
}
