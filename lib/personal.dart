import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'exercise.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key, required this.title}) : super(key: key);

  final String title;
  static List<int> dailyCals = <int>[];
  static List<int> calories = <int>[0];
  static int dayTracker = 0;
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

enum CalorieGoal { lose, maintain, gain }
CalorieGoal? _goal = CalorieGoal.lose;

class _FavoritesPageState extends State<FavoritesPage> {
  final calController = TextEditingController();
  int bmr = 0;
  int count = 1;

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
          Container(
              child: Text(FavoritesPage.calories[0].toString(),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              margin: EdgeInsets.only(top: 20)),
          Row(
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          if (bmr - FavoritesPage.calories[0] >= 1000)
                            return AlertDialog(
                                content: Text("Losing over 2lb/week"));
                          else if (bmr - FavoritesPage.calories[0] >= 500)
                            return AlertDialog(
                                content: Text("Losing ~1lb / week"));
                          else if (bmr - FavoritesPage.calories[0] >= 300)
                            return AlertDialog(
                                content: Text("Slight Caloric Deficit"));
                          else if (bmr - FavoritesPage.calories[0] <= -1000)
                            return AlertDialog(
                                content: Text("Gaining over 2lb/week"));
                          else if (bmr - FavoritesPage.calories[0] <= -500)
                            return AlertDialog(
                                content: Text("Gaining ~1lb/ week"));
                          else if (bmr - FavoritesPage.calories[0] <= -300)
                            return AlertDialog(
                                content: Text("Slight Caloric Surplus"));
                          else
                            return AlertDialog(
                                content: Text("Maintaining Weight"));
                        });
                  },
                  child: const Text('Calculate')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {
                    setState(() {});
                    FavoritesPage.calories[0] = 0;
                  },
                  child: const Text('Reset')),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () {
                setState(() {});
                FavoritesPage.dailyCals.add(FavoritesPage.calories[0]);
                FavoritesPage.calories[0] = 0;
                FirebaseDatabase.instance.reference().child("daily").update({
                  ("calories" + (FavoritesPage.dayTracker).toString()):
                      FavoritesPage.dailyCals[FavoritesPage.dayTracker],
                });
                FavoritesPage.dayTracker++;

                // Navigator.pop(context);
              },
              child: const Text('End Day')),
          Row(
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          if (HomePage.userValues[3] == Sex.female) {
                            bmr = (655 +
                                    (4.3 * int.parse(HomePage.userValues[4])) +
                                    (4.7 * int.parse(HomePage.userValues[2])) -
                                    (4.7 * int.parse(HomePage.userValues[1])))
                                .toInt();
                          } else {
                            bmr = (66 +
                                    (6.3 * int.parse(HomePage.userValues[4])) +
                                    (12.9 * int.parse(HomePage.userValues[2])) -
                                    (6.8 * int.parse(HomePage.userValues[1])))
                                .toInt();
                          }
                          if (HomePage.userValues[0] ==
                              ActivityType.lightlyActive)
                            bmr = (bmr * 1.375).toInt();

                          if (HomePage.userValues[0] ==
                              ActivityType.moderatelyActive)
                            bmr = (bmr * 1.55).toInt();

                          if (HomePage.userValues[0] ==
                              ActivityType.highlyActive)
                            bmr = (bmr * 1.725).toInt();

                          if (HomePage.userValues[0] ==
                              ActivityType.extremelyActive)
                            bmr = (bmr * 1.9.toInt());
                          else
                            bmr = (bmr * 1.2).toInt();

                          return AlertDialog(
                              content: Text("Calories to maintain weight: " +
                                  bmr.toString()));
                        });
                  },
                  child: const Text('Calculate BMR')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepOrange),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          double bmi = 0;
                          String weightClass = "";
                          if (int.parse(HomePage.userValues[1]) >= 18) {
                            bmi = ((int.parse(HomePage.userValues[4]) /
                                    int.parse(HomePage.userValues[2]) /
                                    int.parse(HomePage.userValues[2])) *
                                703);
                            if (bmi < 18.5) weightClass = "Underweight";
                            if (bmi >= 18.5 && bmi <= 24.9)
                              weightClass = "Normal";
                            if (bmi >= 25 && bmi <= 29.9)
                              weightClass = "Overweight";
                            if (bmi >= 30) weightClass = "Obese";
                          } else
                            weightClass = "Undefined";
                          return AlertDialog(content: Text(weightClass));
                        });
                  },
                  child: const Text('Calculate BMI')),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () {
                setState(() {});

                FirebaseDatabase.instance.reference().child("daily").set({});
                FavoritesPage.dayTracker = 0;
                FavoritesPage.dailyCals.clear();
                // Navigator.pop(context);
              },
              child: const Text('Clear Data')),
          Expanded(
              child: ListView.builder(
                  itemCount: FavoritesPage.dailyCals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        ("Day " +
                            ((index + 1).toString()) +
                            ": " +
                            FavoritesPage.dailyCals[index].toString() +
                            " Calories"),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    );
                  }))
        ],
      ),
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
                            FavoritesPage.calories[0] +=
                                int.parse(calController.text);
                            FirebaseDatabase.instance.reference().update({
                              ("calories"): FavoritesPage.calories[0],
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
