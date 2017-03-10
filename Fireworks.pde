// Fred Limouzin
// march 2017
//
// Inspired by Dan Shiffman's "Coding Challenge #27: Fireworks!" (on YouTube)
// but written from scratch.

PVector gravity;
PVector wind;
ArrayList<Flare> flares = new ArrayList<Flare>();
ArrayList<Shooting> shoots = new ArrayList<Shooting>();
Stars stars;

void setup () {
  //fullScreen();
  size(800, 600);
  colorMode(HSB);
  gravity = new PVector(0.0, 0.15);
  wind = new PVector(0.01, 0);
  flares.add(new Flare((width/2), (height+10)));

  background(190, 255, 30); // dark blue in HSB
  stars = new Stars(200);
}

void draw () {
  stars.loadBg();
  for (int i = flares.size()-1; i >= 0; i--) {
    flares.get(i).update();
    if (flares.get(i).isOver()) {
      flares.remove(i);
    } else {
      flares.get(i).show();
    }
  }
  for (int i = shoots.size()-1; i >= 0; i--) {
    shoots.get(i).update();
    if (shoots.get(i).isGone()) {
      shoots.remove(i);
    } else {
      shoots.get(i).show();
    }
  }
  if (random(1) < 0.03) {
    flares.add(new Flare(random(width), (height+10)));
  }
  if (random(1) < 0.005) {
    shoots.add(new Shooting());
  }
}