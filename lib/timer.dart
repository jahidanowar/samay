import 'dart:async';
import 'package:samay/models/timermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  Timer timer;
  Duration _time;
  Duration _fullTime;

  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;

  Future readSettings() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = prefs.getInt('workTime') == null ? 30 : prefs.getInt('workTime'); 
    shortBreak = prefs.getInt('shortBreak') == null ? 5 : prefs.getInt('shortBreak'); 
    longBreak = prefs.getInt('longBreak') == null ? 5 : prefs.getInt('longBreak'); 
  }

  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        numSeconds < 10 ? '0' + numSeconds.toString() : numSeconds.toString();

    String formattedTime = minutes + ':' + seconds;

    return formattedTime;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;
      if (this._isActive) {
        _time = _time - Duration(seconds: 1);
        _radius = _time.inSeconds / _fullTime.inSeconds;
        if (_time.inSeconds <= 0) {
          _isActive = false;
        }
      }
      time = returnTime(_time);
      return TimerModel(time, _radius);
    });
  }

  void startWork() async {
    await readSettings();
    _radius = 1;
    _time = Duration(minutes: this.work, seconds: 0);
    _fullTime = _time;
  }
  void stopTimer(){
    print("Stop");
    this._isActive = false;
  }
  void startTimer(){
    if(this._time.inSeconds > 0){
      this._isActive = true;
    }
  }
  void startBreak(bool inShort){
    _radius = 1;
    _time = Duration(minutes: inShort ? this.shortBreak : this.longBreak, seconds: 0);
    _fullTime = _time;
  }
}
