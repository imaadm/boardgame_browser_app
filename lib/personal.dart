import 'package:flutter/material.dart';
import 'main.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final calController = TextEditingController();

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
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: Text(
                'Total Calories',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Text('data',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {
                  null;
                },
                child: const Text('Calculate')),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4),
              title: const Text('Lose'),
              leading: Radio<ActivityType>(
                value: ActivityType.sedentary,
                groupValue: null,
                onChanged: (ActivityType? value) {
                  setState(() {});
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4),
              title: const Text('Maintain'),
              leading: Radio<ActivityType>(
                value: ActivityType.lightlyActive,
                groupValue: null,
                onChanged: (ActivityType? value) {
                  setState(() {});
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4),
              title: const Text('Gain'),
              leading: Radio<ActivityType>(
                value: ActivityType.moderatelyActive,
                groupValue: null,
                onChanged: (ActivityType? value) {
                  setState(() {});
                },
              ),
            ),
          ],
        ),
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
                          onPressed: null,
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
