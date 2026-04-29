// by Danielle Shifer

class Timer {
  int savedTime, totalTime;
  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }
  void start() {
  
  }
  boolean isFinished() {
    return (millis() - savedTime > totalTime);
  }
}
