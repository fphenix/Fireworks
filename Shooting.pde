// Fred Limouzin
// march 2017

class Shooting {
  PVector pos;
  PVector vel;
  PVector prevpos;
  int c;

  Shooting () {
    this.pos = new PVector(random(width/3), random(height/2));
    this.prevpos = this.pos.copy();
    this.vel = new PVector(1, 0);
    this.vel.mult(random(15, 40));
    float angle = random(-PI/8.0, PI/4.0);
    this.vel.rotate(angle);
    c = int(random(32, 256));
  }

  boolean isGone () {
    return ((this.pos.x > width) || (this.pos.y < 0));
  }

  void update () {
    this.prevpos = this.pos.copy();
    this.pos.add(this.vel);
  }

  void show () {
    strokeWeight(1);
    stroke(this.c);
    line(this.pos.x, this.pos.y, this.prevpos.x, this.prevpos.y);
  }
}