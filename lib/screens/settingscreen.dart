import 'package:flutter/material.dart';
import 'package:samay/widgets/btn.dart';
import 'package:samay/widgets/label.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int workTime;
  int shortBreak;
  int longBreak;

  @override
  void initState() {
    _readSettings();
    super.initState();
  }

  Future _readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    workTime = (prefs.getInt('workTime') == null) ? await prefs.setInt('workTime', 30) : prefs.getInt('workTime');
    shortBreak = (prefs.getInt('shortBreak') == null) ? await prefs.setInt('shortBreak', 5) : prefs.getInt('shortBreak');
    longBreak = (prefs.getInt('longBreak') == null) ? await prefs.setInt('longBreak', 20): prefs.getInt('longBreak');
    setState(() {
      
    });
    print(workTime);
    print(shortBreak);
    print(longBreak);
  }

  void _workTimeController({bool reduce = false}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(reduce){
      workTime--;
    }else{
      workTime++;
    }
    await prefs.setInt('workTime', workTime);
    setState(() {  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(
            text: "Work Time",
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                      Btn(onPressed: () => _workTimeController(reduce: true), text: "-", color: Colors.blueGrey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  this.workTime.toString(),
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Btn(onPressed: () =>  _workTimeController(), text: "+", color: Colors.indigo),
                ),
              ),
            ],
          ),
          Label(
            text: "Short Break",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                      Btn(onPressed: () {}, text: "-", color: Colors.blueGrey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  this.shortBreak.toString(),
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Btn(onPressed: () {}, text: "+", color: Colors.indigo),
                ),
              ),
            ],
          ),
          Label(text: "Long Break"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                      Btn(onPressed: () {}, text: "-", color: Colors.blueGrey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  longBreak.toString(),
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Btn(onPressed: () {}, text: "+", color: Colors.indigo),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
