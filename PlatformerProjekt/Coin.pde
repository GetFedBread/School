class Coin extends GameObject {
  PImage[] coin = new PImage[12];//alle frames i mønte-animationen
  PImage[] erosion = new PImage[3];
  boolean collect;
  Coin(PVector pos, PVector vel, float wIn, float hIn) {
    super(pos,vel,wIn,hIn);
    locked = true;
    for(int i = 1; i<=coin.length; i++) {
      coin[i-1] = loadImage("data/textures/coin/coin"+i+".png");
    }
    for(int i = 1; i<=erosion.length; i++) {
      erosion[i-1] = loadImage("data/textures/coin/coinCollect"+i+".png");
    }
    frame = int(random(0,11));
  }
  
  void draw() {
    if(collect) {
      if(frame>5) {
        frame = 0;
      }
      int tmp = frame/2;
      image(erosion[tmp],position.x,position.y,20,20);
      if(frame==5) {
        position.y = -2000;
        position.x = -2000;
        collect = false;
      }
    }else {
      int tmp = frame/2;
      image(coin[tmp%12],position.x,position.y,20,20);
    }
  }
}
