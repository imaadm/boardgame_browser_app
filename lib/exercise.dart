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
  final workouts = [
    'Walking',
    'Jogging',
    'Biking',
    'Basketball',
    'Calisthenics',
    'Weights'
  ];
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
              child: Text('Cal Pal'),
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
              title: const Text('Calorie Calculator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritesPage(
                            title: 'Calorie Calculator',
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
                      value: ExerciseType.walk,
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
                        value: ExerciseType.jog,
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
                        value: ExerciseType.bike,
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
                setState(() {});
                exerciseTime = swatch.elapsed.inSeconds;
                // if (_ex == ExerciseType.walk)
                // if (_ex == ExerciseType.bike)
                // if (_ex == ExerciseType.jog)
              },
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
