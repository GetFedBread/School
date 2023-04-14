//Indlæser platforme i txt filen som bliver indsendt som et String array.
ArrayList<Platform> loadPlatforms(String[] tmp) {
  ArrayList<Platform> a = new ArrayList<Platform>();
  char[][] tmpchar = new char[tmp.length][];
  for(int i = 0; i<tmp.length; i++) {
    tmpchar[i] = tmp[i].toCharArray();
  }
  for(int i = 0; i<tmp.length; i++) {
    for(int j = 0; j<tmpchar[i].length; j++) {
      /*
      Hvis bogstavet h findes i txt filen bruges et for loop til at finde dens længde.
      for-loopet stopper når et symbol som ikke er en bindestreg nås. 
      */
      if(tmpchar[i][j] == 'h') {
        for(int k = 1; k+j<tmpchar[i].length; k++) {
          if(tmpchar[i][j+k] != '-') {
            a.add(new Platform(new PVector((j-1)*40,(i-1)*40),new PVector(0,0),(j+k)*40-j*40,40));
            j+=k;
            k = tmpchar[i].length;
          }
        }
      }
      /*
      Hvis et v findes er der en lodret platform. 
      for-loopet bevæger sig derfor nedad i stedet for udad i txt filen. 
      */
      if(tmpchar[i][j] == 'v') {
        for(int k = 1; k+i<tmp.length; k++) {
          if(tmpchar[i+k][j] != '|') {
            a.add(new Platform(new PVector((j-1)*40,(i-1)*40),new PVector(0,0),40,(i+k)*40-i*40));
            k = tmp.length;
          }
        }
      }
    }
  }
  return a;
}

//Finder mønter i txt filen som bliver indsendt som et String array.
ArrayList<Coin> loadCoins(String[] tmp) {
  ArrayList<Coin> a = new ArrayList<Coin>();
  char[][] tmpchar = new char[tmp.length][];
  for(int i = 0; i<tmp.length; i++) {
    tmpchar[i] = tmp[i].toCharArray();
  }
  for(int i = 0; i<tmp.length; i++) {
    for(int j = 0; j<tmpchar[i].length; j++) {
      if(tmpchar[i][j] == 'o') {
        a.add(new Coin(new PVector((j-1)*40+10,(i-1)*40+10),new PVector(0,0),(j)*40-j*40,40));
      }
    }
  }
  return a;
}

//Finder fjender i txt filen som bliver indsendt som et String array.
ArrayList<Enemy> loadEnemies(String[] tmp) {
  ArrayList<Enemy> a = new ArrayList<Enemy>();
  char[][] tmpchar = new char[tmp.length][];
  for(int i = 0; i<tmp.length; i++) {
    tmpchar[i] = tmp[i].toCharArray();
  }
  for(int i = 0; i<tmp.length; i++) {
    for(int j = 0; j<tmpchar[i].length; j++) {
      if(tmpchar[i][j] == 'e') {
        a.add(new Enemy(new PVector((j-1)*40+20,(i-1)*40),new PVector(0,0),30,40));
      }
    }
  }
  return a;
}

//Finder spilleren i txt filen som bliver indsendt som et String array.
PVector placePlayer(String[] tmp) {
  PVector player = new PVector(0,0);
  char[][] tmpchar = new char[tmp.length][];
  for(int i = 0; i<tmp.length; i++) {
    tmpchar[i] = tmp[i].toCharArray();
  }
  for(int i = 0; i<tmp.length; i++) {
    for(int j = 0; j<tmpchar[i].length; j++) {
      if(tmpchar[i][j] == 'p') {
        player = new PVector((j-1)*40,(i-1)*40);
      }
    }
  }
  return player;
}
