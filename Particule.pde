// Fred Limouzin //<>// //<>//
// march 2017

class Particule {
  PVector pos;
  PVector vel;
  PVector acc;
  float scl;
  color c;
  float lifespan;
  float lifestep;

  Particule (PVector tpos, float tscl, color tc, int ttype) {
    this.pos = tpos.copy();
    switch (ttype) {
    // circular
    case 0:
      this.vel = PVector.random2D();
      break;
    //heart
    case 1:
      this.vel = this.makeHeart(random(0, 2*PI)).copy();
      this.vel.mult(1.0/20);
      break;
    //square #1
    case 2:
      this.vel = this.makeSquare1(random(0, 2*PI)).copy();
      break;
    // flower
    case 3:
      this.vel = this.makeFlower(random(0, 2*PI)).copy();
      this.vel.mult(1.0/3.0);
      break;
    // Triangle
    case 4:
      this.vel = this.makeTriangle(random(0, 2*PI)).copy();
      this.vel.mult(1.0);
      break;
    // Star
    case 5:
      this.vel = this.makeStar(random(0, 2*PI)).copy();
      this.vel.mult(1.0);
      break;
    //random
    default : 
      this.vel = PVector.random2D();
      this.vel.mult(random(0.1, 0.8));
    }

    this.acc = new PVector(0, 0);
    this.scl = random(tscl);
    this.lifespan = 255.0;
    this.lifestep = random(2.0, 4.0);
    this.c = tc;
  }

  PVector makeHeart (float angle) {
    //x  =  16.sin^3(t) ; y  =  13.cos(t)-5.cos(2t)-2.cos(3t)-cos(4t).
    float x, y, temp;
    temp = sin(angle);
    x = 16*temp*temp*temp;
    y = 13*cos(1.0*angle);
    y -= 5*cos(2.0*angle);
    y -= 2*cos(3.0*angle);
    y -=   cos(4.0*angle);
    return (new PVector(x, -y));
    // other function:
    // x from -2 to 2
    // y1 = sqrt(1 - (abs(x)-1)^2); range from 0 to 1
    // y2 = -3 * sqrt(1 - (sqrt(abs(x)) / sqrt(2))) ; range from 0 to -3
  }

  PVector makeSquare1 (float angle) {
    float x, y, sign;
    x = cos(angle);
    y = 1 - abs(x);
    sign = 1.0 - (2 * floor(random(2)));
    return (new PVector(x, sign * y));
  }  

  PVector makeTriangle (float angle) {
    float x, y;
    float va = PI/5.0;
    if ((angle > PI/2) && (angle < PI+va)) {
      x = -abs(sin(angle));
      y = cos(va) * x;
    } else if ((angle > PI+va) && (angle < 2*PI-va)) {
      x = cos(angle);
      y = -cos(va);
    } else {
      x = abs(sin(angle));
      y = -cos(va) * x;
    }
    return (new PVector(x, -2*y));
  }  

  PVector makeStar (float angle) {
    float sign, ny;
    PVector ret = this.makeTriangle(angle);
    ny = (floor(random(2)) > 0) ? ret.y : 2-ret.y;
    return (new PVector(ret.x, ny));
  }

  PVector makeFlower (float angle) {
    float x, y, r;
    float a = 1.0;
    float b= 1.5;
    float k = 5.0;
    r = 2 * a * sin(k * angle) + b;
    x = r*cos(angle);
    y = r*sin(angle);
    return (new PVector(x, y));
  }  

  void applyForce (PVector force) {
    this.acc.add(force);
  }

  boolean isActive () {
    return (this.lifespan >= 1.0);
  }

  void update () {
    this.applyForce(gravity);
    this.applyForce(wind);
    this.vel.mult(0.995); // friction
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
    this.lifespan -= this.lifestep;
  }

  void show () {
    noStroke();
    fill(this.c, this.lifespan);
    ellipse(this.pos.x, this.pos.y, 2*this.scl, 2*this.scl);
  }
}