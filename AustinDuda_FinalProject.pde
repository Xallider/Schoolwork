/*
Austin Duda
Final Project
INFO-I310
Originally this was suppose to be a side-scroller but I thought it would be better if you could control the character instead of being on a 
tread-mill like platform. Overall I have a lot of undeveloped ideas like a reset, un-added multiple enemies, buffs, collectables, etc.
Due to the time limit and my own neglet of time management and issues of real life it was apparent to me that I didn't have the time to complete all these tasks
thus, this is what i was able to create in the brief time given to us. If possible i would like to finish this project in my own time and even send it
back in just for thoughts/comments even after the semester has ended. Not for a grade but as a thank you for teaching me and helping me along the way.

Thanks!

Austin.


*/





//Global variables
mallow m;
Platform p;
Platform [] platforms;
Platform [] platformG;
Enemy [] enemies;

String gameState;

PImage spriteImages [];
PImage mobImages [];
PImage Platform;
PImage PlatformG;
int frames;
int mobFrames;
int health;
int pHealth;
int songWinNum = 0;
int songLoseNum = 0;
int a; // health warning alpha value
int enemiesDispatched;
int score;
int scorefinal;

int timeleft = 0;
int time;
int wait = 1000;


boolean left, right, up, down, space;
PImage img;
PImage Health;
PImage FireballImage;
FrameObject camera, gameWorld;
ImageObject backImage;

Timer firingTimer;
Fireball [] fireballs;
int nextFireball;


//load sound library
import processing.sound.*;
SoundFile music;
SoundFile Win;
SoundFile Lose;
SoundFile Fireballsound;
SoundFile Jump;
SoundFile Hurt;
SoundFile Slime1;
SoundFile Slime2;
SoundFile Slime3;
SoundFile Start;


//loads upon startup
void setup() {
  size (800, 600); //w,h 800,600
  time = millis();//store the current time

  left = false;        //inputs for character movement
  right = false;
  down = false;
  up = false;
  space = false;

  health = 100;  //set health

  Platform = loadImage("data/map/platform0001.png");          //load images for sprites/platforms/characters/world/etc.
  PlatformG = loadImage("data/map/GroundPlatform.png");
  img = loadImage("data/map/background0001.png");
  Health = loadImage("data/misc/Apple.png");
  FireballImage = loadImage("data/misc/fireball.png");
  backImage = new ImageObject(0, 0, 1200, 1200, img);
  gameWorld = new FrameObject(0, 0, backImage.w, backImage.h);
  camera = new FrameObject(0, 0, width, height); // shift up

  camera.x = (gameWorld.x + gameWorld.w/2) - camera.w/2;    //set camera constraints
  camera.y = (gameWorld.y + gameWorld.h/2) - camera.h/2;


  // sound files
  Win = new SoundFile (this, "data/sounds/fanfare.mp3");
  Fireballsound = new SoundFile (this, "data/sounds/SMRPGFireball.wav");
  Hurt = new SoundFile (this, "data/sounds/SMRPGPunch.wav");
  Start = new SoundFile (this, "data/sounds/SMRPGForestmaze.mp3");
  Lose = new SoundFile (this, "data/sounds/FFXXIIFanFare.mp3");
  Jump = new SoundFile (this, "data/sounds/SMRPGJump.wav");
  //Slime1 = new SoundFile (this, "data/sounds/slime1.wav");
  //Slime2 = new SoundFile (this, "data/sounds/slime2.wav");    //wanted to add in character movement sounds but was really annoying
  //Slime3 = new SoundFile (this, "data/sounds/slime3.wav");

  //character values
  m = new mallow();
  frames = 32;
  spriteImages = new PImage[frames];
  for (int i = 0; i<frames; i++) {
    spriteImages[i]=loadImage("data/characters/mallow"+nf(i+1, 4)+".gif");  //mallow movement frames
  }
  mobFrames=12;
  mobImages = new PImage[mobFrames];    //mob movement frames
  for (int i = 0; i<mobFrames; i++) {
    mobImages[i]=loadImage("data/enemy/slime"+nf(i+1, 4)+".png"); //1-4 move 5-8 idle 9-12 death
  }



  //platform values
  platforms = new Platform[15];
  platforms[0] = new Platform(0, 720, 200, 25, "safe");
  platforms[1] = new Platform(0, 400, 200, 25, "safe");
  platforms[2] = new Platform(150, 150, 200, 25, "safe");
  platforms[3] = new Platform(250, 210, 200, 25, "safe");//
  platforms[4] = new Platform(360, 450, 200, 25, "safe");//
  platforms[5] = new Platform(824, 450, 200, 25, "safe");
  platforms[6] = new Platform(540, 150, 200, 25, "safe");
  platforms[7] = new Platform(660, 300, 200, 25, "safe");
  platforms[8] = new Platform(450, 150, 200, 25, "safe");
  platforms[9] = new Platform(1000, 600, 200, 25, "safe");
  platforms[10] = new Platform(800, 600, 200, 25, "safe");
  platforms[11] = new Platform(600, 600, 200, 25, "safe");
  platforms[12] = new Platform(400, 600, 200, 25, "safe");
  platforms[13] = new Platform(200, 600, 200, 25, "safe");
  platforms[14] = new Platform(300, 100, 200, 25, "safe");
  
  
  //platforms[15] = new Platform(400, 200, 10, 10, "WIN");    // was going to have a platform for winning instead of a "character" but it kept clashing with the current platforms



  //enemy values
  enemies = new Enemy[platforms.length-1];
  for (int i = 1; i < platforms.length; i++) {
    enemies[i-1] = new Enemy(platforms[i]);
  }


  fireballs = new Fireball [50];      //array of fireballs
  for (int i = 0; i < fireballs.length; i++) {
    fireballs[i] = new Fireball();
    //println(fireballs[i]);
  }
  nextFireball = 0;

  firingTimer = new Timer(1500);
  firingTimer.start(); //shift to state of function once states are in



  a = 0;    //variable set here for later alpha value use
  gameState = "START";    //start the game!
}

void draw() {
  pHealth = health;    //set player health = health
  background(255);
  backImage.display();  //-------------- this is causing the screen to be black
  m.update();    //update character



  if (millis() - time >= wait) {                    //time for time left and score
    // println("tick");//if it is, do something
    time = millis();//also update the stored time
  }
  score +=(time/1000);
  timeleft = 300;
  
  
  for (int i = 0; i < platforms.length; ++i) {
    m.collisionSide = rectangleCollisions(m, platforms[i]);      //collision for types of platforms 

    if (m.collisionSide !="none" && platforms[i].typeof == "WIN") {
      health += 1000;//lower health when on bad platform
    }
    //change color when on the ground
    if (pHealth > health) {
      // m.c = color(255, 0, 0); // tints red if you get hurt
    } else {
      // m.c = color(255);
    }
    m.checkPlatforms();
  }


  //enemies
  for (int i = 0; i < enemies.length; ++i) {
    enemies[i].update();
    if (rectangleCollisionsPVE(m, enemies[i]) && !enemies[i].isdead) {
      enemies[i].deathJump();
      health -= 25;
    }
  }

  //fireballs

  if (space) {
    scorefinal -=1;
    if (firingTimer.isFinished()) {
      fireballs[nextFireball].fire(m.x, m.y, m.w, m.facingRight);  //check for fireball input and queue animations
      nextFireball = (nextFireball+1)%fireballs.length;
      firingTimer.start();
      Fireballsound.play();
    }
  }
  
  for (int i = 0; i < fireballs.length; ++i) {            //check for enemy collisions
    fireballs[i].update();
    //Fireballsound.stop();
    for (int j = 0; j < enemies.length; ++j) {
      if (rectangleCollisionsFVE(fireballs[i], enemies[j]) && !enemies[j].isdead) {
        enemies[j].deathJump();
        fireballs[i].reset();
        health +=90;
        scorefinal+=26;
      }
    }
  }


  //move the camera
  camera.x = floor(m.x + (m.halfWidth) - (camera.w /2));
  camera.y = floor(m.y + (m.halfHeight) - (camera.h /2));




  //keep camera inside gameworld boundaries

  if (camera.x < gameWorld.x) {
    camera.x = gameWorld.x;
  }
  if (camera.y < gameWorld.y) {
    camera.y = gameWorld.y;
  }
  if (camera.x + camera.w > gameWorld.x + gameWorld.w) {
    camera.x = gameWorld.x + gameWorld.w - camera.w;
  }
  if (camera.y + camera.h > gameWorld.h) {
    camera.y = gameWorld.h - camera.h;
  }



  translate(-camera.x, -camera.y+100);//shift downward for UI
  pushMatrix();

  m.display();
  for (int i = 0; i < fireballs.length; ++i) {
    fireballs[i].update();
    fireballs[i].display();
  }
  for (int i = 0; i < platforms.length; ++i) {
    platforms[i].display();
  }
  for (int i = 0; i < enemies.length; ++i) {
    enemies[i].display();
  }

  popMatrix();

  displayUI();

   //displayPositionData();



  switch (gameState) {      //set gamestates for win lose or start
  case "START" :
    Start.play();
    gameState = "Standby";
    break;

  case "LOSE" :
    background(0);
    textSize(100);
    fill(255, 255, 255); // White text
    text("Game Over", camera.x+150, camera.y+100);
    //delay(800);
    songLoseNum++;  
    //println(songLoseNum);
    if (songLoseNum == 1) {
      Lose.play();
    }
    if (songLoseNum == 800) {
      songLoseNum = 0;
    }
    break;

  case "WIN" :
    Start.stop();
    scorefinal += (pHealth*100);
    background(random(255), random(255), random(255));
    textSize(100);
    fill(random(255), random(255), random(255)); // rainbow text
    text("You Win!", camera.x+200, camera.y+100);
    text("\nScore:" + scorefinal, camera.x+200, camera.y+100);
    delay(120);
    songWinNum++;
    if (songWinNum == 1) {
      Win.play();
    }
    break;
  }

  if (pHealth != health) {    //character health tracker
    Hurt.play();
    scorefinal-=25;
  }
  if (pHealth<=0) {
    gameState = "LOSE";
    Start.stop();
  }
  if (timeleft == 0) {
    gameState = "LOSE";
    Start.stop();
  }

  if (pHealth >= 1000) {
    gameState = "WIN";
  }
}



boolean rectangleCollisionsPVE(mallow r1, Enemy r2) {    //Player vs enemy collision
  //r1 is the player
  //r2 is the enemy


  float dx = (r1.x+r1.w/2) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/2) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    //collision has happended on the x axis
    //now check y
    if (abs(dy) < combinedHalfHeights) {
      //collision detected
      //determine overlap
      return true;
    }
  }
  return false;
}


boolean rectangleCollisionsFVE(Fireball r1, Enemy r2) {  //fireball vs enemy collision
  //r1 is the player
  //r2 is the enemy

  float dx = (r1.x+r1.w/2) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/2) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    //collision has happended on the x axis
    //now check y
    if (abs(dy) < combinedHalfHeights) {
      //collision detected
      //determine overlap
      return true;
    }
  }
  return false;
}


String rectangleCollisions(mallow r1, Platform r2) {    //platform collision
  //r1 is the player
  //r2 is the platform
  //function returns string collisionside
  //allow to pass through platforms
  //disable if you want to bounce off bottom of platforms
  if (r1.vy < 0) {  
    return "none";
  }

  float dx = (r1.x+r1.w/2) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/2) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    //collision has happended on the x axis
    //now check y
    if (abs(dy) < combinedHalfHeights) {
      //collision detected
      //determine overlap
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      //collision is on axis with smallest overlap

      if (overlapX >= overlapY) {
        if (dy > 0 ) {
          //move rectangle back to eliminate overlap
          //before calling display 
          //to prevent drawing inside eachother
          r1.y+= overlapY;
          return "top";
        } else {
          r1.y-=overlapY;
          return "bottom";
        }
      } else {
        if (dx > 0) {
          r1.x += overlapX;
          return "left";
        } else {
          r1.x -= overlapX;
          return "right";
        }
      }
    } else {
      //collisions failed on y axis
      return "none";
    }
  } else {
    //collisions failed on x axis
    return "none";
  }
}


void displayUI() {  
  //draw health bar
  if (pHealth >= 100) {
    image(Health, camera.x+25, camera.y-75, 24, 24);
    image(Health, camera.x+50, camera.y-75, 24, 24);
    image(Health, camera.x+75, camera.y-75, 24, 24);
    image(Health, camera.x+100, camera.y-75, 24, 24);
  }
  if (pHealth >= 75) {
    image(Health, camera.x+25, camera.y-75, 24, 24);
    image(Health, camera.x+50, camera.y-75, 24, 24);
    image(Health, camera.x+75, camera.y-75, 24, 24);
    ;
  }
  if (pHealth == 50) {
    image(Health, camera.x+25, camera.y-75, 24, 24);
    image(Health, camera.x+50, camera.y-75, 24, 24);
  }
  if (pHealth == 25) {
    image(Health, camera.x+25, camera.y-75, 24, 24);
  }
  if (pHealth == 0) {
    gameState = "LOSE";
  }

  fill(0);
  String s = "\nTime:" +(timeleft-=(time/1000)) +"\nScore: " +scorefinal;     //score
  text(s, camera.x+25, camera.y-50);
}


void resetGame() {      //reset hasnt been implemented
  m.reset();
  score = 0;
  scorefinal = 0;
  enemiesDispatched = 0;
  health = 100;
}



/*
void displayPositionData() {
  fill(0);
  //println(mouseX,mouseY);
  String s = "\nvx: "+m.vx+" vy: " +m.vy + 
    "\ncollisionSide: "+m.collisionSide + "\nGameworld Width: " +gameWorld.w +
    "\nGameworld Height: " +gameWorld.h + "\nHealth: " +health;
  text(s, camera.x, camera.y);
}
*/



//key bindings!

void keyPressed() {
  switch (keyCode) {
  case 37: // left
    left = true;
    break;
  case 39: // right
    right = true;
    break;
  case 38: // up
    up = true;
    Jump.play();
    break;
  case 40: // down
    down = true;
    break;
  case 32: // space
    space = true;
    break;
  }
}

void keyReleased() {
  switch (keyCode) {
  case 37: // left
    left = false;
    break;
  case 39: // right
    right = false;
    break;
  case 38: // up
    Jump.stop();
    up = false;
    break;
  case 40: // down
    down = false;
    break;
  case 32: // space
    space = false;
    break;
  }
}
