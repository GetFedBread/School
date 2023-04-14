// den basale beholder-klasse for spillet
// den har for overskuelighedens skyld både update-metode og  draw-metode

class PlatformerGame {
  PImage heart,background,skull;
  Player player;
  ArrayList<Platform> platforms = new ArrayList<Platform>();
  ArrayList<Coin> coins = new ArrayList<Coin>();
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  boolean levelChange,lose;//Bruges til at se om en transition skal ske
  int level = 1,totalLevels;//Hvilket level spilleren er på

  PlatformerGame() {
    loadSounds();
    totalLevels = int(loadStrings("data/levels/setup.txt")[0]);
    heart = loadImage("data/textures/heart.png");
    skull = loadImage("data/textures/skull.png");
    background = loadImage("data/textures/background.png");
    reset();
  }
  
  void inputHandler(char tast, boolean p){
    tast = Character.toLowerCase(tast);
    player.inputHandler(tast, p);
    if(lose && tast == 'q') {
      lose = false;
      reset();
    }
  }

  void updateGame() {
    if(!music.isPlaying() && !lose) {
      music.play();
    }
    player.update();
    for(Enemy e : enemies) {
      e.update();
    }
    for(Platform p : platforms) {
      p.update();
    }
    //Checks if all coins have been collected
    boolean tmp = false; 
    for(Coin c : coins) {
      c.update();
      if(c.position.y!=-2000) {
        tmp = true;
      }
    }
    //If all coins have been collected then the level changes and gets loaded in
    if(!tmp) {
      if(level<totalLevels) {
        level++;
      }else {
        level = 1;
      }
      if(player.health<totalLevels) {
        player.health++;
      }
      player.score+=3;
      newLevel();
    }
  }

  void drawGame() {
    image(background,0,0);
    for(Coin c : coins) {
      c.draw();
    }
    player.draw();
    for(Enemy e : enemies) {
      e.draw();
    }
    for(Platform p : platforms) {
      p.draw();
    }
    if(!lose) {
      textAlign(LEFT);
      textSize(40);
      fill(255);
      text("Score: "+player.score,10,50);
    }
    for(int i = 0; i<player.health; i++) {
      image(heart,width-((i+1)*60+10),10,50,50);
    }
    fill(255);
    textSize(120);
    textAlign(CENTER);
    if(lose) {
      music.stop();
      image(skull,width/2-128,height/2-360);
      text("Game over. Final score: "+player.score, width/2,height/2);
      text("Press q to try again", width/2,height/2+100);
    }
  }
  
  void reset() {
    player = new Player(new PVector(150,0),new PVector(0,0), 30, 40);
    level = 1;
    coins = loadCoins(loadStrings("data/levels/level"+level+".txt"));
    loadLevel();
  }
  
  void newLevel() {
    coins = loadCoins(loadStrings("data/levels/level"+level+".txt"));
    loadLevel();
  }
  
  //indlæser levels fra txt filer
  void loadLevel() {
    player.velocity = new PVector(0,0);
    platforms = loadPlatforms(loadStrings("data/levels/level"+level+".txt"));
    enemies = loadEnemies(loadStrings("data/levels/level"+level+".txt"));
    player.position = placePlayer(loadStrings("data/levels/level"+level+".txt"));
  }
}
