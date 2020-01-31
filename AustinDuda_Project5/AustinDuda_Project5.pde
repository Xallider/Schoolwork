/*
***********************************
CREATED BY: Austin Duda  11/8/2019
Project 5

        ^                ^

    V                V
A              A
***********************************
*/




PImage Ocarina;
PImage bg;
PImage A;
PImage Up;
PImage Left;
PImage Right;
PImage Down;
PImage DarkOA;
PImage DarkOL;
PImage DarkOR;
PImage DarkOU;
PImage DarkOD;
PImage songofstorms;
PImage[] NoteImg ;
Drop[] drops = new Drop[500]; // array of raindrops
int i = 0;
int k = 0;
boolean f = false;                                          // Variables consisting of all images, two true/false triggers, 2 arrays, a Character swap for a case and two variables used for loops.
boolean g = false;
boolean errorcheck = false;
char letter = 'Z';
int[] songcheck = new int[100];
int[] notepos = new int[100];



//load sound library
import processing.sound.*;
SoundFile Uparrow;
SoundFile Downarrow;
SoundFile Leftarrow;
SoundFile Rightarrow;        //lots of sounds 
SoundFile Abutton;
SoundFile SOS;
SoundFile SOSextended;
SoundFile Correct;
SoundFile Error;




void setup () {

  for (int i = 0; i < drops.length; i++) { // we create the drops       //create raindrops at startup
    drops[i] = new Drop();
  }
  for (int c = 0; c < 100; c++) {    //fill the song array to 100 so nobody crashes the program
    songcheck[c] = 0;
  }


  Uparrow = new SoundFile(this, "UP.wav");    //load note sounds
  Downarrow = new SoundFile(this, "Down.wav");
  Leftarrow = new SoundFile(this, "Left.wav");
  Rightarrow = new SoundFile(this, "Right.wav");
  Abutton = new SoundFile(this, "A.wav");
  SOS = new SoundFile(this, "SOS.mp3");
  SOSextended = new SoundFile(this, "SOSextended.mp3");
  Correct = new SoundFile(this, "correct.wav");
  Error = new SoundFile(this, "Error.wav");

  Ocarina = loadImage("Ocarina.png");        // load all images beforehand
  bg = loadImage("bg.png");
  A=loadImage("A.png");
  Up=loadImage("Up.png");
  Down=loadImage("Down.png");
  Left=loadImage("Left.png");
  Right=loadImage("Right.png");
  songofstorms=loadImage("songofstorms.png");
  DarkOA=loadImage("DarkOA.png");
  DarkOU=loadImage("DarkOU.png");
  DarkOD=loadImage("DarkOD.png");
  DarkOL=loadImage("DarkOL.png");
  DarkOR=loadImage("DarkOR.png");

  size (1600, 950);      //set canvas size and force background image
  background(bg);
}



void draw() {
  image (Ocarina, width/4, 0, width/2, height/2);    //draw top Orcarina

  if (i == 28 && songcheck[5] > 0) {    //checks to see if the correct song is played. Each note has a "value" that adds up, if that value = 28 then the song is played, but it has to be within the first 6 notes, otherwise
    Correct.play();                      // it resets the value score as well as the note position
    SOS.play();                          //if the correct song is played it plays a correct sound, and a short melody followed by activating the true/false swap
    i = 0;
    g = true;
    f = true;
  }

  if (g == true) {          //first true/false swap, if the song is played then it swaps it to true, changing the background and causing rain to fall and the song to play.
    tint(255, 255, 255,75);
    background(songofstorms);
    for (int c = 0; c < drops.length; c++) {
      drops[c].fall(); // sets the shape and speed of drop
      drops[c].show(); // render drop
    }
    if (f == true) {
      SOSextended.play();
      f = false;
    }
  }



  if ( songcheck[6] >0) {          //true false swap to check to see if you play more than 6 notes.
    errorcheck = true;
    k = 0;
    i = 0;
  }
  if (errorcheck == true) {
    Error.play();
    errorcheck = false;


    redraw();            //if  more than 6 notes are played the "canvas" is reset to remove the notes previously played.
    background(bg);
    image (Ocarina, width/4, 0, width/2, height/2);
    for (int p = 0; p <100; p++) {
      songcheck[p] = 0;
    }
  }



  switch(letter) {            //case statment to assign "values" to each note position. Each note has a different value weight, ranging from 1-5
  case 'A': 
    notepos[k] = 1;
    break;
  case 'B': 
    notepos[k] = 2;
    break;
  case 'C': 
    notepos[k] = 3;
    break;
  case 'D':  
    notepos[k] = 4;
    break;
  case 'E':  
    notepos[k] = 5;
    break;
  default:
    k = 0;   
    break;
  }


  if (notepos[k] == 1) {
    image(A, (397+(k*100)), (880), 45, 45);        //sets the note positions according to the note position currently in play. The first note will come first then shift over to show what notes are being played.
  }
  if (notepos[k] == 2) {
    image(Up, (397+(k*100)), (880-150), 45, 45);
  }
  if (notepos[k] == 3) {
    image(Down, (397+(k*100)), (876-45), 45, 45);
  }
  if (notepos[k] == 4) {
    image(Left, (397+(k*100)), (876-70), 45, 45);
  }
  if (notepos[k] == 5) {
    image(Right, (397+(k*100)), (880-90), 45, 45);
  }
}
