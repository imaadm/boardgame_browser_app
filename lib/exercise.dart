import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'personal.dart';

class ExercisePage extends StatefulWidget {
  ExercisePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

enum ExerciseType { light, moderate, vigorous }
ExerciseType? _ex = ExerciseType.light;

class _ExercisePageState extends State<ExercisePage> {
  final workouts = [
    'Hiking',
    'Jogging',
    'Biking',
    'Basketball',
    'Calisthenics',
    'Weights'
  ];
  double met = 0;
  String? value;
  bool startIsPressed = true;
  bool stopIsPressed = true;
  bool resetIsPressed = true;
  String displayTime = "00:00:00";
  int exerciseTime = 0;
  var swatch = Stopwatch();
  final duration = const Duration(seconds: 1);

  void startTimer() {
    Timer(duration, runTimer);
  }

  void runTimer() {
    if (swatch.isRunning) {
      startTimer();
    }
    setState(() {
      displayTime = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startStopwatch() {
    setState(() {
      stopIsPressed = false;
      startIsPressed = false;
    });
    swatch.start();
    startTimer();
  }

  void resetStopWatch() {
    setState(() {
      startIsPressed = true;
      resetIsPressed = true;
    });
    swatch.reset();
    displayTime = "00:00:00";
  }

  void stopStopwatch() {
    setState(() {
      stopIsPressed = true;
      resetIsPressed = false;
    });
    swatch.stop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontSize: 20),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Cal Pal',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text('Personal'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            title: 'Personal',
                          )),
                );
              },
            ),
            ListTile(
              title: const Text('Calculator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritesPage(
                            title: 'Calculator',
                          )),
                );
              },
            ),
            ListTile(
              title: const Text('Exercise'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExercisePage(
                            title: 'Exercise',
                          )),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 110,
                child: ListTileTheme(
                  horizontalTitleGap: -2,
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: -4),
                    title: Row(
                      children: [
                        const Text('Light'),
                      ],
                    ),
                    leading: Radio<ExerciseType>(
                      value: ExerciseType.light,
                      groupValue: _ex,
                      onChanged: (ExerciseType? value) {
                        setState(() {
                          _ex = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                  width: 140,
                  child: ListTileTheme(
                    horizontalTitleGap: -2,
                    child: ListTile(
                      visualDensity: VisualDensity(horizontal: -4),
                      title: Row(
                        children: [
                          const Text('Moderate'),
                        ],
                      ),
                      leading: Radio<ExerciseType>(
                        value: ExerciseType.moderate,
                        groupValue: _ex,
                        onChanged: (ExerciseType? value) {
                          setState(() {
                            _ex = value;
                          });
                        },
                      ),
                    ),
                  )),
              Container(
                  width: 135,
                  child: ListTileTheme(
                    horizontalTitleGap: -2,
                    child: ListTile(
                      visualDensity: VisualDensity(horizontal: -4),
                      title: Flexible(
                        flex: 5,
                        child: Row(
                          children: [
                            const Text('Vigorous'),
                          ],
                        ),
                      ),
                      leading: Radio<ExerciseType>(
                        value: ExerciseType.vigorous,
                        groupValue: _ex,
                        onChanged: (ExerciseType? value) {
                          setState(() {
                            _ex = value;
                          });
                        },
                      ),
                    ),
                  ))
            ],
          ),
          Divider(),
          DropdownButton<String>(
            value: value,
            items: workouts.map(buildMenuItem).toList(),
            onChanged: (value) => setState(() => this.value = value),
          ),
          Text(
            displayTime,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: startStopwatch,
                  child: const Text('Start')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: stopStopwatch,
                  child: const Text('Stop')),
            ],
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: resetStopWatch,
              child: const Text('Reset')),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () {
                final FirebaseAuth auth = FirebaseAuth.instance;
                final User? user = auth.currentUser;
                final uid = user!.uid;
                setState(() {});
                showDialog(
                  context: context,
                  builder: (context) {
                    if (_ex == ExerciseType.light) {
                      if (value == workouts[0]) met = 5.3; //hiking
                      if (value == workouts[1]) met = 6; //jogging
                      if (value == workouts[2]) met = 6.8; //biking
                      if (value == workouts[3]) met = 6; //basketball
                      if (value == workouts[4]) met = 2.8; //calisthenics
                      if (value == workouts[5]) met = 3.5; //weights
                    }
                    if (_ex == ExerciseType.moderate) {
                      if (value == workouts[0]) met = 6; //hiking
                      if (value == workouts[1]) met = 7; //jogging
                      if (value == workouts[2]) met = 7.5; //biking
                      if (value == workouts[3]) met = 6.5; //basketball
                      if (value == workouts[4]) met = 3.8; //calisthenics
                      if (value == workouts[5]) met = 5; //weights
                    }
                    if (_ex == ExerciseType.vigorous) {
                      if (value == workouts[0]) met = 7.8; //hiking
                      if (value == workouts[1]) met = 9; //jogging
                      if (value == workouts[2]) met = 10; //biking
                      if (value == workouts[3]) met = 8; //basketball
                      if (value == workouts[4]) met = 8; //calisthenics
                      if (value == workouts[5]) met = 6; //weights
                    }
                    int calsBurned = (((int.parse(HomePage.userValues[5]) *
                                0.453592) *
                            3.5 *
                            met *
                            (swatch.elapsed
                                    .inSeconds /* 1200  set to 1200 seconds (20minutes) for test*/ /
                                60)) ~/
                        200);
                    FirebaseDatabase.instance.reference().update({
                      ("user" + uid + "/calories"): FavoritesPage.calories[0] -=
                          calsBurned,
                    });
                    return AlertDialog(
                        content:
                            Text('Calories Burned: ' + calsBurned.toString()));
                  },
                );
              },
              child: const Text('Finish Exercise')),
        ],
      ),
    );
  }
}
