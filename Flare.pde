// Fred Limouzin
// march 2017

class Flare {
  PVector pos;
  PVector vel;
  PVector acc;
  float scl;
  int typeShape;
  boolean active;
  boolean reachedTop;
  boolean exploded;
  boolean finished;
  int nbParticules;
  color c;
  ArrayList<PVector> tail = new ArrayList<PVector>();
  float tailLen = 30;
  ArrayList<Particule> exploPart = new ArrayList<Particule>();

  Flare (float tx, float ty) {
    float minNbPart = 200;
    float maxNbPart = 300;
    this.typeShape = int(random(12));
    this.pos = new PVector(tx, ty);
    this.vel = new PVector(0, (-1.0 * random(10.0, 15.0)));
    this.acc = new PVector(0, 0);
    this.scl = random(2, 5);
    this.nbParticules = int(random(minNbPart, maxNbPart));
    this.active = true;
    this.reachedTop = false;
    this.exploded = false;
    this.finished = false;
    colorMode(HSB);
    this.c = color(int(random(256)), 255, 255);
  }

  boolean isActive() {
    return this.active;
  }

  boolean isAtApogee () {
    return (this.vel.y >= 0.0);
  }

  void explode () {
    for (int i = 0; i < this.nbParticules; i++) {
      this.exploPart.add(new Particule(this.pos, this.scl, this.c, this.typeShape));
    }
  }

  void updateChildren () {
    for (int i = (this.exploPart.size()-1); i >= 0; i--) {
      this.exploPart.get(i).update();
      if (!this.exploPart.get(i).isActive()) {
        this.exploPart.remove(i);
      }
    }
  }

  void noTail () {
    for (int i = (this.tail.size()-1); i >= 0; i--) {
      this.tail.remove(i);
    }
  }

  void applyForce (PVector force) {
    this.acc.add(force);
  }

  boolean isOver () {
    return this.finished;
  }

  void update () {
    if (this.exploded && (this.exploPart.size() < 1)) {
      this.finished = true;
      return;
    }
    this.reachedTop = this.isAtApogee();
    if (!this.reachedTop) {
      this.tail.add(this.pos.copy());
      while (this.tail.size() > this.tailLen) {
        this.tail.remove(0);
      }
      this.applyForce(gravity);
      this.applyForce(wind);
      this.vel.add(this.acc);
      this.pos.add(this.vel);
      this.vel.mult(0.995); // friction
    } else if (!this.exploded) {
      this.explode();
      this.noTail();
      this.exploded = true;
    }
    this.acc.mult(0);
    this.updateChildren();
  }

  void showChildren () {
    for (int i = 0; i < this.exploPart.size(); i++) {
      this.exploPart.get(i).show();
    }
  }

  void show () {
    if (!this.exploded) {
      strokeWeight(this.scl);
      stroke(this.c);
      fill(this.c);
      PVector startpos, endpos;
      for (int i = this.tail.size()-2; i > 0; i--) {
        stroke(this.c, 25.5*i);
        startpos = this.tail.get(i);
        endpos = this.tail.get(i+1);
        line(startpos.x, startpos.y, endpos.x, endpos.y);
      }
      ellipse(this.pos.x, this.pos.y, 2*this.scl, 2*this.scl);
    } else {
      this.showChildren();
    }
  }
}
