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
  game.inputHandler(key, true);
}
void keyReleased(){
  game.inputHandler(key, false);
}
