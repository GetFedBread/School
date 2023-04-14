/*
Lydfiler indlæses her siden jeg ikke kan få processing til at indlæse filer i en klasse:
"The constructor "SoundFile(Player, String)" does not exist"
"The constructor "SoundFile(PlatformerGame, String)" does not exist"

Det ser ud til at "this" i tilfældet af indlæselse af en SoundFile skal refererer til
hovedklassen.
*/
SoundFile footsteps,music,coin,jump,damage,lose;

void loadSounds() {
  footsteps = new SoundFile(this,"data/sound/footsteps.mp3");
  music = new SoundFile(this,"data/sound/background.mp3");
  music.amp(0.3);
  coin = new SoundFile(this,"data/sound/coin.wav");
  jump = new SoundFile(this,"data/sound/jump.mp3");
  damage = new SoundFile(this,"data/sound/damage.wav");
  lose = new SoundFile(this,"data/sound/lose.wav");
}
