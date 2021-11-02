import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

enum CalorieGoal { lose, maintain, gain }
CalorieGoal? _goal = CalorieGoal.lose;

class _FavoritesPageState extends State<FavoritesPage> {
  final calController = TextEditingController();
  int calories = 0;

  @override
  void dispose() {
    calController.dispose();
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
          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Text(
              'Calorie Goal Calculator',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
          Text(calories.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: const Text('Lose'),
            leading: Radio<CalorieGoal>(
              value: CalorieGoal.lose,
              groupValue: _goal,
              onChanged: (CalorieGoal? value) {
                setState(() {
                  _goal = value;
                });
              },
            ),
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: const Text('Maintain'),
            leading: Radio<CalorieGoal>(
              value: CalorieGoal.maintain,
              groupValue: _goal,
              onChanged: (CalorieGoal? value) {
                setState(() {
                  _goal = value;
                });
              },
            ),
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: const Text('Gain'),
            leading: Radio<CalorieGoal>(
              value: CalorieGoal.gain,
              groupValue: _goal,
              onChanged: (CalorieGoal? value) {
                setState(() {
                  _goal = value;
                });
              },
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {},
                  child: const Text('Calculate')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {
                    setState(() {});
                    calories = 0;
                    FirebaseDatabase.instance.reference().child("user").update({
                      "calories": calories,
                    }).then((value) {
                      return AlertDialog(content: Text("Data Saved"));
                    }).catchError((error) {
                      return AlertDialog(content: Text("Save Unsuccessful"));
                    });
                  },
                  child: const Text('Reset')),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      TextFormField(
                          decoration: const InputDecoration(
                              icon: Icon(Icons.fastfood),
                              hintText: 'Input a number',
                              labelText: 'Calories'),
                          controller: calController),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: () {
                            setState(() {});
                            calories += int.parse(calController.text);
                            FirebaseDatabase.instance
                                .reference()
                                .child("user")
                                .update({
                              "calories": calories,
                            }).then((value) {
                              return AlertDialog(content: Text("Data Saved"));
                            }).catchError((error) {
                              return AlertDialog(
                                  content: Text("Save Unsuccessful"));
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Add Meal')),
                    ],
                  ),
                ));
              });
        },
        tooltip: 'Add meal',
        child: Icon(Icons.add),
      ),
    );
  }
}
