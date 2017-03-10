// Fred Limouzin
// march 2017

class Stars {
  Stars (int nbstars) {
    init(nbstars);
  }

  void init (int nbs) {
    for (int n = 0; n < nbs; n++) {
      strokeWeight(random(3));
      stroke(random(32, 255));
      point(random(width), random(height));
      loadPixels(); // store stars background
    }
  }

  void loadBg() {
    updatePixels(); // load stars background
  }
}