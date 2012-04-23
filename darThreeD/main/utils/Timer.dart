class Timer extends Event
{
  int _currentCount = 0;
  var _timer;
  
  Timer()
  {
    
  }
  
  void start()
  {
    _timer = window.setInterval(tickHandler, 100);
  }
  
  void pause()
  {
    window.clearInterval(_timer);
  }
  
  void stop()
  {
    window.clearInterval(_timer);
    _currentCount = 0;
  }
  
  void tickHandler()
  {
    _currentCount++;
  }
  
  int get currentCount() { return _currentCount; }
}
