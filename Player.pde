class mallow {
  float w, h, x, y, vx, vy, 
    accelerationX, accelerationY, 
    speedLimit;

  //world variables
  float friction, bounce, gravity, c;

  boolean isonground;
  float jumpForce;

  float halfWidth, halfHeight;
  String collisionSide;

  //image variables
  int currentFrame;
  boolean facingRight;
  int frameSequence;
  int frameOffset;


  mallow() {
    w = 32;
    h = 35;
    x = 24;
    y = 400;//1564
    vx = 0;
    vy = 0;
    accelerationX = 0;
    accelerationY = 0;
    speedLimit = 5;
    isonground = true;
    jumpForce = -10;

    //world values
    friction = 0.96;
    bounce = -0.7;
    gravity = .3;

    halfWidth = w/2;
    halfHeight = h/2;

    collisionSide = "";

    currentFrame = 0;
    facingRight = true;
    frameSequence = 16; // number of frames in each animation sequence
    frameOffset = 0;
  }



  void update() {
    //starts friction at 1

    if (left && !right) {
      accelerationX = -0.2;
      friction = 1;
      facingRight = false;
    }
    if (right && !left) {
      accelerationX = 0.2;
      friction = 1;
      facingRight = true;
    }
    if (!left && !right) {
      accelerationX = 0;
    }


    if (up && !down && isonground) {
      //accelerationY = -0.2;
      // need to use vy instead of accelerationY
      //beacuse it gets modified by gravity
      vy = jumpForce;
      isonground = false;
      // gravity = 0;
      friction = 1;
      //jump sound goes here
    }


    if (down && !up) {
      //accelerationY = 0.2;
      // friction = 1;
    }
    if (!up && down) {
      // accelerationY = 0;
    }
    //removing impulse  reintroduces friction
    if (!up && !down && !left && !right) {
      friction = 0.93;
      //gravity = 0.8;
    }

    vx += accelerationX;
    vy += accelerationY;

    //friction 1 = no friction
    vx *= friction;
    // vy *= friction;

    //apply gravity
    vy += gravity;

    //correct for maximum speeds
    if (vx > speedLimit) {
      vx = speedLimit;
    } 
    if (vx < -speedLimit) {
      vx = -speedLimit;
    }
    //need to let gravity ramp up
    if (vy > 3* speedLimit) {
      vy = 3 * speedLimit;
    }
    //dont need when jumping
    if (vy < -speedLimit) {
      //vy = -speedLimit;
    }

    //correct minimum speeds
    if (abs(vx) < 0.2) {
      vx = 0;
    }
    if (abs(vy) < 0.2) {
      vy = 0;
    }



    //move the player
    // x+=vx;
    //y+=vy;

    x = Math.max(0, Math.min(x + vx, gameWorld.w - w));
    y = Math.max(0, Math.min(y + vy, gameWorld.h - h));


    checkBoundaries();
    checkPlatforms();
  }


  void checkPlatforms() {
    //update platform for collisions

    if (collisionSide == "bottom" && vy >=0) {
      if (vy < 1) {
        isonground = true;
        vy = 0;
        //println("top");
      } else {
        //reduce bounce for floor bounce
        //vy *=bounce/2;
        vy = 0;
      }
    } else if (collisionSide == "top" && vy <=0) {
      vy = 0;
    } else if (collisionSide == "right" && vx >=0) {
      vx = 0;
    } else if (collisionSide == "left" && vx <=0) {
      vx = 0;
    }
    if (collisionSide != "bottom" && vy > 0) {
      isonground = false;
    }
  }







  void checkBoundaries() {
    //check boundaries
    //left
    if (x <= 0) {
      vx *= bounce;
      x = 0;
      facingRight = !facingRight;
    }

    //right
    if ( x >= gameWorld.w - w) {
      vx *=bounce;
      x = gameWorld.w - w;
      facingRight = !facingRight;
    }


    //top
    if (y <= 0) {
      vy *= bounce;
      y = 0;
    }

    //bottom
    if ( y >= gameWorld.h - h) {
      if (vy < 1) {
        isonground = true;
        vy = 0;
      } else {
        //reduced bounce for floor
        vy *= bounce/2;
      }
      y = camera.h - h; // updated from height 


      //y = height - h;
      //can kill the bounce by adding these
      //isonground = true;
      //  vy = 0;
    }
  }

  void reset() {
    x = gameWorld.w/2 - w/2;
    y = (gameWorld.y + gameWorld.h /2) - h/2;
    vx = 0;
    vy = 0;
    accelerationX = 0;
    accelerationY = 0;
    speedLimit = 10;
    isonground = false;
  }

  void display() {
    fill(255, 255, 255, 0);
    stroke(0 ,0, 0, 0);
    rect(x, y, w, h);
    //println(x, y);
    //tint(c);
    if (facingRight) {
      if (abs(vx) > 0) {
        image(spriteImages[currentFrame+16], x-5, y-5, 48, 48);//walking right
      } else {
        image(spriteImages[currentFrame+0], x-5, y-5, 48, 48); //standing still 12
      }
    } else {
      if (abs(vx) > 0) {
        pushMatrix();
        scale(-1, 1);
        image(spriteImages[currentFrame+16], -x-35, y-5, 48, 48);
        popMatrix();
        //image(spriteImages[currentFrame+16], x-10, y-27, 48, 48);
      } else {
        pushMatrix();
        scale(-1, 1);
        image(spriteImages[currentFrame+0], -x-35, y-5, 48, 48);
        // tint(255, 0, 255,); changes mallow's color, can be used for goal sprite
        popMatrix();
        //image(spriteImages[currentFrame+0], x-10, y-27); //standing still left  18
      }
    }
    if (isonground) {
      currentFrame = (currentFrame + 1) % frameSequence;
    } else {
      currentFrame = 0;
    }
  }
}
