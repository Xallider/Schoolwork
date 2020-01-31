class Drop {
  float x; // xxz position of the raindrops
  float y; 
  float z; 
  float leng; // length and speed of raindrops
  float yspeed; 

  //near means closer to the screen , ie the higher the z value ,closer the drop is to the screen.
  Drop() {
    x  = random(width); // random x position along the width of the screen
    y  = random(-500, -50); // random y position, negative values to start at the very bottom to imitate a dropping effect
    z  = random(0, 20); // z value is to give a perspective view , farther and nearer drops effect
    leng = map(z, 0, 20, 10, 20); // z provides a "dragging" effect to make the raindrops longer
    yspeed  = map(z, 0, 20, 1, 20); // if z is near drop is faster
  }

  void fall() { // function  to determine the speed and shape of the drop 
    y = y + yspeed; // speed affects the y positon, increasing the length in return 
    float grav = map(z, 0, 20, 0, 0.2); // gravity increases speed
    yspeed = yspeed + grav; // speed 

    if (y > height) { // repositions the drop after leaving screen
      y = random(-200, -100);
      yspeed = map(z, 0, 20, 4, 10);
    }
  }

  void show() { // function to render the drop onto the screen
    float thick = map(z, 0, 20, 1, 3); //if z is near , drop is more thicker 
    strokeWeight(thick); // weight of the drop
    stroke(255, 255, 255); // rain color
    line(x, y, x, y+leng); //draws 2 points of the line
  }
}
