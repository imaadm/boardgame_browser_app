import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'personal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(title: 'Fitness App'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

enum ActivityType {
  sedentary,
  lightlyActive,
  moderatelyActive,
  highlyActive,
  extremelyActive
}
ActivityType? _type = ActivityType.sedentary;

enum Sex { male, female }
Sex? _sex = Sex.male;

class _HomePageState extends State<HomePage> {
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
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
          Padding(
              padding: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: weightController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Weight'),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: heightController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Height'),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: ageController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Age'),
                    ),
                  )
                ],
              )),
          Divider(
            height: 30,
          ),
          Column(children: [
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              title: const Text('Male'),
              leading: Radio<Sex>(
                value: Sex.male,
                groupValue: _sex,
                onChanged: (Sex? value) {
                  setState(() {
                    _sex = value;
                  });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              title: const Text('Female'),
              leading: Radio<Sex>(
                value: Sex.female,
                groupValue: _sex,
                onChanged: (Sex? value) {
                  setState(() {
                    _sex = value;
                  });
                },
              ),
            ),
            Divider(
              height: 30,
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              title: const Text('Sedentary'),
              leading: Radio<ActivityType>(
                value: ActivityType.sedentary,
                groupValue: _type,
                onChanged: (ActivityType? value) {
                  setState(() {
                    _type = value;
                  });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              title: const Text('Lightly Active'),
              leading: Radio<ActivityType>(
                value: ActivityType.lightlyActive,
                groupValue: _type,
                onChanged: (ActivityType? value) {
                  setState(() {
                    _type = value;
                  });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              title: const Text('Moderately Active'),
              leading: Radio<ActivityType>(
                value: ActivityType.moderatelyActive,
                groupValue: _type,
                onChanged: (ActivityType? value) {
                  setState(() {
                    _type = value;
                  });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              title: const Text('Highly Active'),
              leading: Radio<ActivityType>(
                value: ActivityType.highlyActive,
                groupValue: _type,
                onChanged: (ActivityType? value) {
                  setState(() {
                    _type = value;
                  });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -4),
              title: const Text('Extremely Active'),
              leading: Radio<ActivityType>(
                value: ActivityType.extremelyActive,
                groupValue: _type,
                onChanged: (ActivityType? value) {
                  setState(() {
                    _type = value;
                  });
                },
              ),
            ),
            Divider(),
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
                        int bmr = 0;
                        if (_sex == Sex.female) {
                          bmr = (655 +
                                  (4.3 * int.parse(weightController.text)) +
                                  (4.7 * int.parse(heightController.text)) -
                                  (4.7 * int.parse(ageController.text)))
                              .toInt();
                        } else {
                          bmr = (66 +
                                  (6.3 * int.parse(weightController.text)) +
                                  (12.9 * int.parse(heightController.text)) -
                                  (6.8 * int.parse(ageController.text)))
                              .toInt();
                        }
                        if (_type == ActivityType.lightlyActive)
                          bmr = (bmr * 1.375).toInt();

                        if (_type == ActivityType.moderatelyActive)
                          bmr = (bmr * 1.55).toInt();

                        if (_type == ActivityType.highlyActive)
                          bmr = (bmr * 1.725).toInt();

                        if (_type == ActivityType.extremelyActive)
                          bmr = (bmr * 1.9.toInt());
                        else
                          bmr = (bmr * 1.2).toInt();

                        return AlertDialog(content: Text(bmr.toString()));
                      });
                },
                child: const Text('Calculate Calories')),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {
                  FirebaseDatabase.instance
                      .reference()
                      .child("user")
                      .once()
                      .then((datasnapshot) {
                    print("Successful");
                    var userValues = [];
                    datasnapshot.value.forEach((k, v) {
                      print(k);
                      print(v);
                      userValues.add(v);
                    });
                  });
                  showDialog(
                      context: context,
                      builder: (context) {
                        double bmi = 0;
                        String weightClass = "";
                        if (int.parse(ageController.text) >= 18) {
                          bmi = ((int.parse(weightController.text) /
                                  int.parse(heightController.text) /
                                  int.parse(heightController.text)) *
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
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {
                  FirebaseDatabase.instance.reference().child("user").update({
                    "age": ageController.text,
                    "weight": weightController.text,
                    "height": heightController.text,
                    "sex": _sex.toString(),
                    "activity": _type.toString()
                  }).then((value) {
                    return AlertDialog(content: Text("Data Saved"));
                  }).catchError((error) {
                    return AlertDialog(content: Text("Save Unsuccessful"));
                  });
                },
                child: const Text('Save Data')),
          ])
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
