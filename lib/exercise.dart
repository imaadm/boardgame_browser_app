import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';
import 'personal.dart';

class ExercisePage extends StatefulWidget {
  ExercisePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

enum ExerciseType { walk, jog, bike }
ExerciseType? _ex = ExerciseType.walk;

class _ExercisePageState extends State<ExercisePage> {
  bool startIsPressed = true;
  bool stopIsPressed = true;
  bool resetIsPressed = true;
  String displayTime = "00:00:00";
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
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Calculator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            title: 'Calculator',
                          )),
                );
              },
            ),
            ListTile(
              title: const Text('Favorites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritesPage(
                            title: 'Favorites',
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
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: const Text('Walk'),
            leading: Radio<ExerciseType>(
              value: ExerciseType.walk,
              groupValue: _ex,
              onChanged: (ExerciseType? value) {
                setState(() {
                  _ex = value;
                });
              },
            ),
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: const Text('Jog'),
            leading: Radio<ExerciseType>(
              value: ExerciseType.jog,
              groupValue: _ex,
              onChanged: (ExerciseType? value) {
                setState(() {
                  _ex = value;
                });
              },
            ),
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: const Text('Bike'),
            leading: Radio<ExerciseType>(
              value: ExerciseType.bike,
              groupValue: _ex,
              onChanged: (ExerciseType? value) {
                setState(() {
                  _ex = value;
                });
              },
            ),
          ),
          Text(
            displayTime,
            style: TextStyle(fontSize: 40),
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
                  onPressed:
                      startStopwatch, //startIsPressed ? startStopwatch : null,
                  child: const Text('Start')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed:
                      stopStopwatch, //stopIsPressed ? null : stopStopwatch,
                  child: const Text('Stop')),
            ],
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed:
                  resetStopWatch, //resetIsPressed ? null : resetStopWatch,
              child: const Text('Reset')),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed:
                  resetStopWatch, //resetIsPressed ? null : resetStopWatch,
              child: const Text('Finish Exercise')),
        ],
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         label: 'FavoritesButton',
      //         icon: IconButton(
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => FavoritesPage(
      //                           title: 'Favorites',
      //                         )),
      //               );
      //               setState(() {
      //                 _iconColor = Colors.blue;
      //               });
      //             },
      //             icon: Icon(
      //               Icons.favorite,
      //               color: _iconColor,
      //             ))),
      //     BottomNavigationBarItem(
      //         label: 'BrowseButton',
      //         icon: IconButton(
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => HomePage(
      //                           title: 'Browse',
      //                         )),
      //               );
      //               setState(() {
      //                 _iconColor = Colors.blue;
      //               });
      //             },
      //             icon: Icon(
      //               Icons.favorite,
      //               color: _iconColor,
      //             ))),
      //     BottomNavigationBarItem(
      //         label: 'SettingsButton',
      //         icon: IconButton(
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => GamePage(
      //                           title: 'Settings',
      //                         )),
      //               );
      //             },
      //             icon: Icon(Icons.settings))),
      //   ],
      //   fixedColor: Colors.grey,
      // ),
    );
  }
}
