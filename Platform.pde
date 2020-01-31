class Platform {
  float w, h, x, y;
  String typeof;
  float halfWidth, halfHeight;

  Platform(int _x, float _y, float _w, float _h, String _typeof) {
    w = _w;
    h = _h;
    x = _x;
    y = _y;
    typeof = _typeof;

    halfWidth = w/2;
    halfHeight = h/2;
    
   
  }
 
  void display() {
    //if (typeof == "safe"{ can be used for harmful platforms
    image(Platform,x,y);
   // stroke(0);
    fill(0, 0, 255,0);
    rect(x, y, w, h);
  }
}///// setup for platform to pass values
