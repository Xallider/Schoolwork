class Fireball {
  float w = 20;
  float h = 20;
  float x = 0;
  float y = -h;
  float halfWidth = w / 2;
  float halfHeight = h / 2;
  float vx = 0;
  float vy = 0;
  boolean inMotion = false;

  float leftBound = 0;
  float rightBound = 0;
  float lowerBound = 0;
  float upperBound = 0;

//check to see if fireball needs to be on screen or not
void fire(float mx, float my, float mw, boolean mfacingRight) {
    if (!inMotion) {
        y = my - 3; // change to lower fireball position
      inMotion = true;
      if (mfacingRight == true) {
        vx = 15;
        x = mx + mw - 35; //shift starting point for laser to right side of mallow
      } else {
        vx = -15;
        x = mx;
      }
    }
  }
//reset fireball animation
  void reset() {
    x = 0;
    y = -h;
    vx = 0;
    vy = 0;
    inMotion = false;
  }

  void update() {
    // only update fireball if its on screen otherwise no
    if (inMotion) {
      x += vx;
      y += vy;
    }
    ////check boundaries
    rightBound = Math.max(camera.w, m.x + m.halfWidth + camera.w / 2);
    leftBound = camera.x;
    upperBound = camera.y;
    lowerBound = Math.max(camera.h, m.y + m.halfHeight + camera.h / 2);
    if (x < leftBound || x > rightBound || y < upperBound || y > lowerBound) { //boundaries so fireballs dont go off screen.
      reset();
    }
  }

/*
 void update() {
    if (inMotion) {
      x += vx;
      y += vy;
    }
    ////check boundaries
    if (x < 0 || x > width || y < 0 || y > height) {
      reset();
    }
  }
  */
  void display() {    //display fireball
    //fill(255,0,0);
    //rect(x+5, y+10, w, h);
    if (abs(vx) > 0) {
      image(FireballImage, x, y);
    }
    
  }
}
