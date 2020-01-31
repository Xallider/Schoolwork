class Timer {
  int startTime;
  int interval;

  Timer(int tempTime) {
    interval=tempTime;
  }

  void start() {
    startTime=millis();
  }

  boolean isFinished() {
    int elapsedTime = millis() - startTime;
    if (elapsedTime>interval) {
      return true;
    } else {
      return false;
    }
  }
}  //time for fireballs
