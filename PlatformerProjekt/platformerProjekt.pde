import processing.sound.*;
PlatformerGame game;

void setup() {
  fullScreen();
  game = new PlatformerGame();
  frameRate(60);
}

void draw() {
  clear();
  game.updateGame();
  game.drawGame();
}

void keyPressed(){
  /*Den følgende kode blev brugt til at teste koden. der navigeres mellem levels med op og ned piletasterne.*/
  /* 
  if(keyCode == UP && game.level<int(loadStrings("data/levels/setup.txt")[0])) {
    game.level++;
    game.newLevel();
  }
  if(keyCode == DOWN && game.level>1) {
    game.level--;
    game.newLevel();
  }
  */
  game.inputHandler(key, true);
}
void keyReleased(){
  game.inputHandler(key, false);
}
