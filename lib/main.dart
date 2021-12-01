import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'personal.dart';
import 'exercise.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user!.uid;
  int tempCount = 0;
  FirebaseDatabase.instance
      .reference()
      .child("user" + uid)
      .once()
      .then((datasnapshot) {
    print("Successful");
    datasnapshot.value.forEach((k, v) {
      print(v);
      (HomePage.userValues).add(v);
    });
  });
  FirebaseDatabase.instance
      .reference()
      .child("daily" + uid)
      .once()
      .then((datasnapshot) {
    print("Successful");
    datasnapshot.value.forEach((k, v) {
      tempCount++;
      // print(k);
      print(v);
      (FavoritesPage.dailyCals).add(v);
    });
    FavoritesPage.dayTracker = tempCount;
  });

  FavoritesPage.calories[0] = HomePage.userValues[2];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cal Pal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginPage(title: 'Login'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  static var userValues = [];

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
          Padding(
              padding: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: weightController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Weight'),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: heightController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Height'),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,
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
                        MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User? user = auth.currentUser;
                  final uid = user!.uid;
                  FirebaseDatabase.instance
                      .reference()
                      .child("user" + uid)
                      .update({
                    "age": ageController.text,
                    "weight": weightController.text,
                    "height": heightController.text,
                    "calories": 0,
                    "sex": _sex.toString(),
                    "activity": _type.toString()
                  }).then((value) {
                    return AlertDialog(content: Text("Data Saved"));
                  }).catchError((error) {
                    return AlertDialog(content: Text("Save Unsuccessful"));
                  });
                  (HomePage.userValues).clear();
                  FirebaseDatabase.instance
                      .reference()
                      .child("user" + uid)
                      .once()
                      .then((datasnapshot) {
                    print("Successful");
                    datasnapshot.value.forEach((k, v) {
                      print(v);
                      (HomePage.userValues).add(v);
                    });
                  });
                  print(HomePage.userValues);
                },
                child: const Text('Save Data')),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {
                  setState(() {});
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User? user = auth.currentUser;
                  final uid = user!.uid;
                  FirebaseDatabase.instance
                      .reference()
                      .child("user" + uid)
                      .set({});
                },
                child: const Text('Clear Data')),
          ])
        ],
      ),
    );
  }
}
