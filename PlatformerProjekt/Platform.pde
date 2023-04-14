class Platform extends GameObject {
  PImage floor,wall;
  Platform(PVector pos, PVector vel, float wIn, float hIn) {
    super(pos,vel,wIn,hIn);
    locked = true;
    wall = loadImage("data/textures/tiles/wall.png");
    floor = loadImage("data/textures/tiles/floor.png");
  }
  
  /*
  Fortæller hvilken side spilleren kolliderer med. 
  Bruges til at se om spilleren står oven på en platform eller om de kan walljumpe
  */
  int collisionSide(PVector posIn, float wIn, float hIn) {
    if(posIn.x+wIn>position.x-2 && posIn.x+wIn<position.x+2 && posIn.y+hIn>position.y-2 && posIn.y<position.y+h+2) {
      return 1;
    }
    if(posIn.x>position.x+w-2 && posIn.x<position.x+w+2 && posIn.y+hIn>position.y-2 && posIn.y<position.y+h+2) {
      return 2;
    }
    if(posIn.x+wIn>position.x-2 && posIn.x<position.x+w+2 && posIn.y+hIn>position.y-2 && posIn.y+hIn<position.y+2) {
      return 3;
    }
    if(posIn.x+wIn>position.x-2 && posIn.x<position.x+w+2 && posIn.y>position.y-2 && posIn.y<position.y+h+2) {
      return 4;
    }
    return 0;
  }
  
  //Brugt når spilleren er inde i en platform for at få dem ud af platformen
  PVector uncollide(PVector posIn, float wIn, float hIn) {
    float tmpX,tmpY;
    if(abs(position.x-(posIn.x+wIn))<abs((position.x+w)-posIn.x)) {
      tmpX = position.x-(posIn.x+wIn);
    }else {
      tmpX = (position.x+w)-posIn.x;
    }
    if(abs(position.y-(posIn.y+hIn))<abs((position.y+h)-posIn.y)) {
      tmpY = position.y-(posIn.y+hIn);
    }else {
      tmpY = (position.y+h)-posIn.y;
    }
    if(abs(tmpX)<abs(tmpY)) {
      posIn.add(tmpX,0);
    }else {
      posIn.add(0,tmpY);
    }
    return posIn;
  }
  
  void draw() {
    if(w>=h) {
      for(int i = 0; i<w; i+=40) {
        image(floor,position.x+i,position.y,40,40);
      }
    }else {
      for(int i = 0; i<h; i+=40) {
        image(wall,position.x,position.y+i,40,40);
      }
    }
  }
}
