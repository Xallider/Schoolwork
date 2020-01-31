class Enemy {
  float w, h, x, y, vx, vy, 
    accelerationX, accelerationY, 
    speedLimit;

  float leftEdge, rightEdge, ground;

  //world variables
  float friction, bounce, gravity;
  float jumpForce;
  boolean isdead;
  //boolean isonground;
  //float jumpForce;

  float halfWidth, halfHeight;
  //string collisionSide;

  //image variables
  int delay = 4;
  int currentFrame;
  boolean facingRight;
  int frameSequence;
  int frameOffset;
  int soundDelay;

  color c;

  Enemy(Platform p) {
    w = 24;
    h = 24;
    halfWidth = w/2;
    halfHeight = h/2;
    x = p.x + p.w/2 - halfWidth;
    y = p.y - h - 100;

    leftEdge = p.x;
    rightEdge = p.x + p.w;
    ground = p.y;

    vx = (random(10)<5)? - 1 : 1;
    vy = 0;
    accelerationX = 0;
    accelerationY = 0;
    speedLimit = 10;
    //  isonground = false;
    jumpForce = -10;


    //world values
    friction = 0.96;
    bounce = -0.7;
    gravity = .3;

    //collisionSide = "";

    currentFrame = 0;
    facingRight = true;
    frameSequence = 4; // number of frames in each animation sequence
    frameOffset = 0;

    c = color(255);
    isdead = false;
  }

  void update() {

    vy += gravity;

    //need to let gravity ramp up
    if (vy > 3* speedLimit) {
      vy = 3 * speedLimit;
    }

    //correct minimum speeds
    if (abs(vy) < 0.2) {
      vy = 0;
    }

    x = Math.max(0, Math.min(x + vx, rightEdge- w));
    y = Math.max(0, Math.min(y + vy, ground - h));
    checkBoundaries();
  }

  void deathJump() {
    isdead = true;
    vy = jumpForce;
    vx = 0;

    ground = gameWorld.h;
  }


  void checkBoundaries() {
    //check boundaries
    //left
    if (x <= leftEdge) {
      vx *= -1;
      x = leftEdge;
    }

    //right
    if ( x >= rightEdge - w) {
      vx *= -1;
      x = rightEdge - w;
    }

    //ground
    if ( y >= ground - h) {
      if (vy < 1) {
        vy = 0;
      } else {
        vy *= bounce/2;
      }
      y = ground - h;
    }
  }


  void reset() {
    x = p.x + p.w /2 - halfWidth;
    y = p.y - h - 100;

    leftEdge = p.x;
    rightEdge = p.x + p.w;
    ground = p.y;
    vx = (random(10) < 5) ? - 1 : 1;
    isdead = false;
  }


  void display() {
    stroke(255,255,255,0);
    fill(255, 255, 255, 0); //hitboxes
    rect(x, y, w, h);


    if (abs(vx) > 0) {
      facingRight= true;
      if (facingRight) {
        image(mobImages[currentFrame+0], x-10, y-18, 48, 48);//walking right
        //facingRight = false;
        //tint(random(255), random(255), random(255));
        /*
        
         soundDelay++;            // slime sound for movement, didnt like how it wasnt random enough or too random.
         println(soundDelay);
         
         switch (soundDelay) {
         case 300 :
         Slime1.play();
         soundDelay = 350;
         break;
         case  350 :
         Slime1.stop();
         Slime2.stop();
         Slime3.stop();
         break;
         case 800 :
         Slime2.play();
         soundDelay = 850;
         break;
         case 851 :
         Slime1.stop();
         Slime2.stop();
         Slime3.stop();
         break;
         case 1300 : 
         Slime3.play();
         soundDelay = 1350;
         break;
         case 1351 :
         Slime1.stop();
         Slime2.stop();
         Slime3.stop();
         soundDelay = 0;
         soundDelay += random(1340);
         break;
         
         }
         if (soundDelay >= 800) {
         }
         if (soundDelay >= 1300) {
         Slime3.play();
         soundDelay = 0;
         soundDelay+= random(280);
         Slime1.stop();
         Slime2.stop();
         Slime3.stop();
         }
         */
      }
    }
//mob animation frames
    if (abs(vx) == 0) {
      image(mobImages[currentFrame+8], x-10, y-18, 48, 48); //standing still
    }


    if (abs(vx) >= 0) {

      if (frameCount % delay == 0) {
        currentFrame = (currentFrame + 1) % frameSequence;
      }
    } else {
      currentFrame = 0;
    }
  }
}
