class ImageObject {
  float w, h, x, y;
  PImage img ;
  PImage ground;
  PImage gameOver;
  int frames;
  float halfWidth, halfHeight;

  ImageObject(int _x, float _y, float _w, float _h, PImage _img) {
    w = _w;
    h = _h;
    x = _x;
    y = _y;
    img= _img;
    

    halfWidth = w/2;
    halfHeight = h/2;
  }

  void display() {
    image(img, x, y);// one large image can be used
    //image(img, x+w, y);
    //image(img, x+2  *w, y);
  }

}      ///// used for backimage
