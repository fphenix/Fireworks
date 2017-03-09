// Fred Limouzin
// march 2017
//
// Inspired by Dan Shiffman's "Coding Challenge #27: Fireworks!" (on YouTube)
// but written from scratch.

PVector gravity;
PVector wind;
ArrayList<Flare> flares = new ArrayList<Flare>();

void setup () {
  //fullScreen();
  size(800, 600);
  gravity = new PVector(0.0, 0.08);
  wind = new PVector(0.003, 0.0005);
  flares.add(new Flare((width/2), (height+10)));

  background(0, 0, 24);
  starsInit(200);
}

void draw () {
  stars();
  for (int i = flares.size()-1; i >= 0; i--) {
    flares.get(i).update();
    if (flares.get(i).isOver()) {
      flares.remove(i);
    } else {
      flares.get(i).show();
    }
  }
  if (random(1) < 0.02) {
    flares.add(new Flare(random(width), (height+10)));
  }
}

void starsInit (int nbs) {
  for (int n = 0; n < nbs; n++) {
    strokeWeight(random(3));
    stroke(random(32, 255));
    point(random(width), random(height));
    loadPixels(); // store stars background
  }
}

void stars() {
  updatePixels(); // load stars background
}