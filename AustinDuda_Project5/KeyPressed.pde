void keyPressed() {
  if (key == 'a') {                    //if the A button is pressed, load the A button image, assign i a "weighted value" 
    Abutton.play();                    //played A button note.
    image(DarkOA, width/4, 0, width/2, height/2);  
    i += 2;
    songcheck[k] = 1;// set songcheck array to make sure song isnt > than 6 notes
    notepos[k] = 1;  //sets relative note position "weighted value"
    letter = 'A';  //sets case to "a"
    k++;      //increment counter
  }

  if (key == CODED) {
    if (keyCode == UP) {      //if the A button is pressed, load the A button image, assign i a "weighted value" 
      Uparrow.play();      //plays up arrow note.
      image(DarkOU, width/4, 0, width/2, height/2);
      i += 5;
      songcheck[k] = 1;// set songcheck array to make sure song isnt > than 6 notes
      notepos[k] = 2;//sets relative note position "weighted value"
      letter = 'B';//sets case to "B"
      k++;//increment counter
    }
  }
  if (key == CODED) {
    if (keyCode == DOWN) {
      Downarrow.play();
      image(DarkOD, width/4, 0, width/2, height/2);
      i += 7;
      songcheck[k] = 1;// set songcheck array to make sure song isnt > than 6 notes
      notepos[k] = 3;//sets relative note position "weighted value"
      letter = 'C';//sets case to "C"
      k++;//increment counter
    }
  }
  if (key == CODED) {
    if (keyCode == LEFT) {
      Leftarrow.play();
      image(DarkOL, width/4, 0, width/2, height/2);
      i += 9;
      songcheck[k] = 1;// set songcheck array to make sure song isnt > than 6 notes
      notepos[k] = 4;//sets relative note position "weighted value"
      letter = 'D';//sets case to "D"
      k++;//increment counter
    }
  }
  if (key == CODED) {
    if (keyCode == RIGHT) {
      Rightarrow.play();
      image(DarkOR, width/4, 0, width/2, height/2);
      i += 12;
      songcheck[k] = 1;// set songcheck array to make sure song isnt > than 6 notes
      notepos[k] = 5;//sets relative note position "weighted value"
      letter = 'E';//sets case to "E"
      k++;//increment counter
    }
  }
}
