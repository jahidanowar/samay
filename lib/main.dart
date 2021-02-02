import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:samay/models/timermodel.dart';
import 'package:samay/screens/settingscreen.dart';
import 'package:samay/timer.dart';
import 'package:samay/widgets/btn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: "Nunito"),
        home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  final CountDownTimer timer = CountDownTimer();
  final double defaultPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = List<PopupMenuItem<String>>();
    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));
    timer.startWork();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Samay'.toUpperCase(),
          style: TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
              if (s == 'Settings') {
                goToSettings(context);
              }
            },
          )
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double availableWidth = constraints.maxWidth;

        return Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Btn(
                      onPressed: () => timer.startWork(),
                      text: "Work",
                      color: Colors.indigo,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Btn(
                      onPressed: () => timer.startBreak(true),
                      text: "Short Break",
                      color: Colors.indigoAccent,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Btn(
                      onPressed: () => timer.startBreak(false),
                      text: "Long Break",
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ],
            ),
            StreamBuilder(
                initialData: "00:00",
                stream: timer.stream(),
                builder: (context, AsyncSnapshot snapshot) {
                  TimerModel timer = (snapshot.data == '00:00')
                      ? TimerModel("00:00", 1)
                      : snapshot.data;
                  return Expanded(
                    child: CircularPercentIndicator(
                      radius: availableWidth / 2,
                      lineWidth: 10.0,
                      percent: timer.percent,
                      center: Text(
                        timer.time,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      progressColor: Colors.indigoAccent,
                    ),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Btn(
                      onPressed: () => timer.stopTimer(),
                      text: "STOP",
                      color: Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Btn(
                      onPressed: () => timer.startTimer(),
                      text: "START",
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      }),
    );
  }

  void goToSettings(BuildContext context) {
    print('in gotoSettings');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }
}
